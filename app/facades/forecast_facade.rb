class ForecastFacade
  def self.get_forecast(params)
    coordinates = GeocodingService.get_coordinates(params[:location])

    return coordinates if coordinates[:status] == 400

    city_coordinates = create_coordinates(coordinates)

    return city_coordinates if city_coordinates[:status] == 400

    weather_info = WeatherService.get_weather(city_coordinates)

    return weather_info if weather_info[:status] == 400

    Weather.new(weather_info)
  end

  def self.create_coordinates(coordinates)
    lat_lng_map = coordinates[:results].first[:locations].first[:latLng]
    coords = {lat: lat_lng_map[:lat], long: lat_lng_map[:lng]}
  end
end
