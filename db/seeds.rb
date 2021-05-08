require "csv"
require "open-uri"
require "json"

# subway
subway_stop_url = "http://web.mta.info/developers/data/nyct/subway/Stations.csv"
subway_stop_uri = URI.open(subway_stop_url)

CSV.new(subway_stop_uri, headers: :first_row).each do |line|
  subway_stop = SubwayStop.create!(
    gtfs_id: line.dig("GTFS Stop ID"),
    line_name: "#{line.dig("Division")} #{line.dig("Line")} Line",
    stop_name: line.dig("Stop Name"),
    routes: line.dig("Daytime Routes").split(" "),
  )
  puts "Created subway stop #{subway_stop.line_name} #{subway_stop.stop_name}"
end

# bus
key = Rails.application.secrets.MTA_BUS_API_KEY
base_url = "http://bustime.mta.info/api/where"
bus_stop_uri = URI.open("#{base_url}/stop-ids-for-agency/MTA.json?key=#{key}")
bus_stop_result = JSON.parse(bus_stop_uri.read)
bus_stop_result.dig("data", "list").each do |stop|
  begin
    bus_info_uri = URI.open("#{base_url}/stop/#{stop}.json?key=#{key}")
    bus_info_result = JSON.parse(bus_info_uri.read)
    bus_stop = BusStop.create!(
      code: bus_info_result.dig("data", "code"),
      stop_id: bus_info_result.dig("data", "id"),
      name: bus_info_result.dig("data", "name"),
      direction: bus_info_result.dig("data", "direction"),
    )
    puts "Created bus stop #{bus_stop.name}"
  rescue => exception
    p "ERROR for #{stop}: #{exception.to_s}"
  end
end
