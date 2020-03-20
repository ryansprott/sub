module Api
  class SubwayStopsController < ApplicationController
    require 'protobuf'
    require 'google/transit/gtfs-realtime.pb'

    def index
      stops  = SubwayStop.all.sort_by(&:gtfs_id).uniq

      output = stops.map do |stop|
        {
          label: stop.label,
          value: stop.gtfs_id
        }
      end

      render json: output
    end

    def show
      nb, sb  = {}, {}
      stop    = SubwayStop.find_by(gtfs_id: params[:id])

      unless stop.nil?
        for route in stop.routes do
          feed = SubwayService.get_feed(route)
          for entity in feed.entity do
            if entity.field?(:trip_update)
              entity.trip_update.stop_time_update.each do |item|
                route_id = entity.trip_update.trip.route_id
                mins_away = item.arrival.nil? ? 0 : (item.arrival.time - DateTime.now.to_time.to_i) / 60
                if item.stop_id == stop.gtfs_id + 'N'
                  nb[route_id] = [] unless nb.has_key? route_id
                  nb[route_id] << arriving(mins_away, item.arrival.time) if mins_away > 0 && nb[route_id].length < 4
                elsif item.stop_id == stop.gtfs_id + 'S'
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

      render json: {"NB" => nb, "SB" => sb}
    end

    private

    def arriving(mins_away, arrival_time)
      timestamp = Time.at(arrival_time).strftime("%H:%M")
      "#{mins_away.to_s} min (#{timestamp})"
    end

    def natural_sort(array)
      array.sort_by! {|e| e.split(/(\d+)/).map {|a| a =~ /\d+/ ? a.to_i : a }}
    end
  end
end
