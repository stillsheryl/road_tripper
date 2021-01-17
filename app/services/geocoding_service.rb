class GeocodingService
  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com') do |f|
      f.params["key"] = ENV["GEOCODING_API_KEY"]
    end
  end

  def self.get_coordinates(city)
    response = conn.get('/geocoding/v1/address') do |req|
      req.params["location"] = city
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
