class WeatherFacade
  def self.weather(params)
    weather_info = WeatherService.get_weather(params)

    Weather.new(weather_info)
  end
end
