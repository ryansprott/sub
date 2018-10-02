require 'csv'
require 'open-uri'
require 'json'

# subway
subway_stop_url = "http://web.mta.info/developers/data/nyct/subway/Stations.csv"

CSV.new(open(subway_stop_url), :headers => :first_row).each do |line|
  subway_stop = SubwayStop.create!(
    gtfs_id: line["GTFS Stop ID"],
    line_name: line["Division"] + " " + line["Line"] + " Line",
    stop_name: line["Stop Name"],
    routes: line["Daytime Routes"].split(' ')
  )
  puts "Created subway stop #{subway_stop.line_name } #{subway_stop.stop_name}"
end

# bus
key = Rails.application.secrets.MTA_BUS_API_KEY
base_url = "http://bustime.mta.info/api/where"
bus_stops = []

bus_stop_result = JSON.parse(open("#{base_url}/stop-ids-for-agency/MTA.json?key=#{key}").read)

bus_stop_result['data']['list'].each do |item|
  bus_stops << item
end

bus_stops.each do |stop|
  begin
    bus_info_result = JSON.parse(open("#{base_url}/stop/#{stop}.json?key=#{key}").read)
    bus_stop = BusStop.create!(
      code: bus_info_result['data']['code'],
      stop_id: bus_info_result['data']['id'],
      name: bus_info_result['data']['name'],
      direction: bus_info_result['data']['direction']
    )
    puts "Created bus stop #{bus_stop.name}"
  rescue => exception
    p "ERROR for #{stop}: #{exception.to_s}"
  end
end
