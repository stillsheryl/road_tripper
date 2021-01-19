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
      hours = (driving_time[0].to_f / 3600).round

      if hours <= 48
        hourly_weather = WeatherService.hourly_weather(city_coordinates)
        trip[:temperature] = hourly_weather[:hourly][hours][:temp]
        trip[:conditions] = hourly_weather[:hourly][hours][:weather].first[:description]
        trip[:travel_time] = driving_time[1]

      else
        day = hours / 24
        daily_weather = WeatherService.get_weather(city_coordinates)
        trip[:temperature] = daily_weather[:daily][day][:temp][:day]
        trip[:conditions] = daily_weather[:daily][day][:weather].first[:description]
        trip[:travel_time] = driving_time[1]
      end
    end
    trip
  end
end
