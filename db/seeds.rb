# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
require 'open-uri'
url = "http://web.mta.info/developers/data/nyct/subway/Stations.csv"

CSV.new(open(url), :headers => :first_row).each do |line|  
  stop = Stop.create!(
    gtfs_id: line["GTFS Stop ID"],
    line_name: line["Division"] + " " + line["Line"] + " Line",
    stop_name: line["Stop Name"],
    routes: line["Daytime Routes"].split(' '),
    lat: line["GTFS Latitude"],
    lon: line["GTFS Longitude"]
  )
end
