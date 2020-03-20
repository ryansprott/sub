class SubwayService
  @api_key = Rails.application.secrets.MTA_SUBWAY_API_KEY

  def self.get_feed(route)
    feed_id = feeds_by_route(route)
    url     = "http://datamine.mta.info/mta_esi.php?key=#{@api_key}&feed_id=#{feed_id}"
    data    = Net::HTTP.get(URI.parse(url))
    Transit_realtime::FeedMessage.decode(data)
  end

  private

  def self.feeds_by_route(route)
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
