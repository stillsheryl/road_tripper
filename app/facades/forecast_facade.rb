class ForecastFacade
  def self.get_forecast(params)
    coordinates = GeocodingService.get_coordinates(params[:location])

    return coordinates if coordinates[:status] == 400

    weather_info = WeatherService.get_weather(coordinates)

    return weather_info if weather_info[:status] == 400

    Weather.new(weather_info)
  end
end
