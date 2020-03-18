class BusService
  @api_key = Rails.application.secrets.MTA_BUS_API_KEY

  def self.get_arrivals(stop_id)
    url     = "http://bustime.mta.info/api/siri/stop-monitoring.json?key=#{@api_key}&MonitoringRef=#{stop_id}"
    data    = JSON.parse(Net::HTTP.get(URI.parse(url)))
    visits  = data.dig('Siri', 'ServiceDelivery', 'StopMonitoringDelivery').first.dig('MonitoredStopVisit')
    arrivals = visits.map do |visit|
      journey = visit.dig('MonitoredVehicleJourney')
      call    = journey.dig('MonitoredCall')
      dists   = call.dig('Extensions', 'Distances')
      {
        published_line_name: journey.dig('PublishedLineName'),
        destination_name: journey.dig('DestinationName'),
        expected_arrival_time: call.dig('ExpectedArrivalTime'),
        presentable_distance: dists.dig('PresentableDistance'),
        stops_from_call: dists.dig('StopsFromCall')
      }
    end
    arrivals
  end
end
