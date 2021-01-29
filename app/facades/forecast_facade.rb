class ForecastFacade
  def self.get_forecast(params)
    coordinates = GeocodingService.get_coordinates(params[:location])

    return error_message(params) if coordinates[:error] == true

    weather_info = WeatherService.get_weather(coordinates)

    return error_message(params) if weather_info[:error] == true

    Weather.new(weather_info)
  end

  def self.error_message(params)
    { message: "Unknown Location: #{params[:location]}", status: 400, error: true }
  end
end
