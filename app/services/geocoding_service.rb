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

    body = JSON.parse(response.body, symbolize_names: true) if response.body != ''

    if response.body == '' || city == ''
      {:message => "Unknown Location: #{city}", :status => 400}
    elsif body[:results].first[:locations].first[:geocodeQualityCode][0..1] == "A5"
      map_data = JSON.parse(response.body, symbolize_names: true)
      create_coordinates(map_data)
    else
      {:message => "Unknown Location: #{city}", :status => 400}
    end
  end

  def self.create_coordinates(map_data)
    lat_lng_map = map_data[:results].first[:locations].first[:latLng]
    coords = {lat: lat_lng_map[:lat], long: lat_lng_map[:lng]}
  end
end
