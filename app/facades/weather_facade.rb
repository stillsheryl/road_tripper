class WeatherFacade
  def self.weather(params)
    weather_info = WeatherService.get_weather(params)

    Weather.new(weather_info)
  end

  def self.weather_at_time(params, city_coordinates, driving_time)
    hourly_weather = WeatherService.hourly_weather(city_coordinates)

    hours = (driving_time[0].to_f / 3600).round

    trip = {}
    trip[:temperature] = hourly_weather[:hourly][hours][:temp]
    trip[:conditions] = hourly_weather[:hourly][hours][:weather].first[:description]
    trip[:travel_time] = driving_time[1]
    trip[:start_city] = params[:origin]
    trip[:end_city] = params[:destination]

    trip
  end
end
