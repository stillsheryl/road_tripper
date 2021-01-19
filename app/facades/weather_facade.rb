class WeatherFacade
  def self.weather(params)
    weather_info = WeatherService.get_weather(params)
    if weather_info[:status] == 400
      weather_info
    else
      Weather.new(weather_info)
    end
  end

  def self.weather_at_time(params, city_coordinates, driving_time)
    trip = {}
    trip[:start_city] = params[:origin]
    trip[:end_city] = params[:destination]

    if driving_time == "Impossible"
      trip[:temperature] = ""
      trip[:conditions] = ""
      trip[:travel_time] = "Impossible"

      trip

    else
      hourly_weather = WeatherService.hourly_weather(city_coordinates)

      hours = (driving_time[0].to_f / 3600).round

      trip[:temperature] = hourly_weather[:hourly][hours][:temp]
      trip[:conditions] = hourly_weather[:hourly][hours][:weather].first[:description]
      trip[:travel_time] = driving_time[1]

      trip
    end
  end

    def self.weather_at_destination(city_coordinates, travel_times)
      hourly_weather = WeatherService.hourly_weather(city_coordinates)

      added_hours = (travel_times[0].to_f / 3600).round

      trip = {}

      trip[:temperature] = hourly_weather[:hourly][added_hours][:temp]
      trip[:conditions] = hourly_weather[:hourly][added_hours][:weather].first[:description]
      trip[:travel_time] = travel_times[1]

      trip
    end
end
