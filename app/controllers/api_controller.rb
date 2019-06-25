class ApiController < ApplicationController
  require 'protobuf'
  require 'google/transit/gtfs-realtime.pb'
  require 'net/http'

  def all_equipment
    render json: Equipment.all
  end

  def all_subway_stops
    render json: SubwayStop.all.pluck(:gtfs_id, :line_name, :stop_name)
  end

  def all_bus_stops
    render json: BusStop.all.pluck(:id, :code, :name, :direction)
  end

  def service_status
    data = Net::HTTP.get(URI.parse('http://web.mta.info/status/ServiceStatusSubway.xml'))
    hsh  = Hash.from_xml(data)
    rsp  = hsh['Siri']['ServiceDelivery']['SituationExchangeDelivery']['Situations']['PtSituationElement']
    out  = []
    rsp.each do |item|
      out.push({
        affects: item['Affects']['VehicleJourneys']['AffectedVehicleJourney'],
        consequences: item['Consequences'],
        long_description: item['LongDescription'],
        planned: item['Planned'],
        priority: item['MessagePriority'],
        start: item['PublicationWindow']['StartTime'],
        end: item['PublicationWindow']['EndTime'],
        reason: item['ReasonName'],
        summary: item['Summary']
      })
    end
    render json: JSON.parse(out.to_json)
  end

  def equipment_status
    data = Net::HTTP.get(URI.parse('http://web.mta.info/developers/data/nyct/nyct_ene.xml'))
    hsh  = Hash.from_xml(data)
    render json: JSON.parse(hsh['NYCOutages']['outage'].to_json)
  end

  def bus_arrivals
    api_key = Rails.application.secrets.MTA_BUS_API_KEY
    stop_id = params[:id]
    url     = "http://bustime.mta.info/api/siri/stop-monitoring.json?key=#{api_key}&MonitoringRef=#{stop_id}"
    data    = JSON.parse(Net::HTTP.get(URI.parse(url)))
    render json: JSON.parse(data['Siri']['ServiceDelivery']['StopMonitoringDelivery'][0]['MonitoredStopVisit'].to_json)
  end

  def subway_arrivals
    nb      = {}
    sb      = {}
    stop_id = params[:id]
    api_key = Rails.application.secrets.MTA_SUBWAY_API_KEY
    stop    = SubwayStop.find_by(gtfs_id: stop_id)
    unless stop.nil?
      for route in stop.routes do
        feed_id = feeds_by_route(route)
        data    = Net::HTTP.get(URI.parse("http://datamine.mta.info/mta_esi.php?key=#{api_key}&feed_id=#{feed_id}"))
        feed    = Transit_realtime::FeedMessage.decode(data)
        for entity in feed.entity do
          if entity.field?(:trip_update)
            entity.trip_update.stop_time_update.each do |item|
              route_id = entity.trip_update.trip.route_id
              mins_away = item.arrival.nil? ? 0 : (item.arrival.time - DateTime.now.to_time.to_i) / 60
              if item.stop_id == stop_id + 'N'
                nb[route_id] = [] unless nb.has_key? route_id
                nb[route_id] << arriving(mins_away, item.arrival.time) if mins_away > 0 && nb[route_id].length < 4
              elsif item.stop_id == stop_id + 'S'
                sb[route_id] = [] unless sb.has_key? route_id
                sb[route_id] << arriving(mins_away, item.arrival.time) if mins_away > 0 && sb[route_id].length < 4
              end
            end
          end
        end
      end
    end
    # make sure the keys (i.e. services) are sorted
    nb = Hash[nb.sort_by { |key, value| key }]
    sb = Hash[sb.sort_by { |key, value| key }]
    # then sort the arrival times
    nb.each { |key, value| value = natural_sort(value) }
    sb.each { |key, value| value = natural_sort(value) }
    render json: JSON.parse({"NB" => nb, "SB" => sb}.to_json)
  end

  private

  def arriving(mins_away, arrival_time)
    timestamp = Time.at(arrival_time).strftime("%H:%M")
    "#{mins_away.to_s} min (#{timestamp})"
  end

  def natural_sort(array)
    array.sort_by! {|e| e.split(/(\d+)/).map {|a| a =~ /\d+/ ? a.to_i : a }}
  end

  def feeds_by_route(route)
    feeds = {
      "1" => ['1', '2', '3', '4', '5', '6', '6X', 'GS'],
      "26" => ['A', 'C', 'E', 'H', 'FS'],
      "16" => ['N', 'Q', 'R', 'W'],
      "21" => ['B', 'D', 'F', 'M'],
      "2" => ['L'],
      "11" => ['SI'],
      "31" => ['G'],
      "36" => ['J', 'Z'],
      "51" => ['7', '7X']
    }
    feeds.each { |key, val|
      return key if val.include? route
    }
    nil
  end

end
