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

    body = JSON.parse(response.body, symbolize_names: true)

    if invalid_input(body)
      
    else
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  def self.invalid_input(body)
    body[:results].first[:locations].first[:geocodeQualityCode] == 39.390897 && body[:results].first[:locations].first[:displayLatLng][:lng] == -99.066067
  end
end
