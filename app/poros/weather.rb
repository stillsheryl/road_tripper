class Weather
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather,
              :id

  def initialize(weather_data)
    @current_weather = current_weather_hash(weather_data[:current])
    @daily_weather = daily_weather_for_5_days(weather_data[:daily])
    @hourly_weather = hourly_weather_for_8_hours(weather_data[:hourly])
    @id = nil
  end

  def current_weather_hash(weather_data)
    {
      datetime: DateTime.strptime(weather_data[:dt].to_s,'%s').strftime("%Y/%m/%d %k:%M:%S %z"),
      sunrise: DateTime.strptime(weather_data[:sunrise].to_s,'%s').strftime("%Y/%m/%d %k:%M:%S %z"),
      sunset: DateTime.strptime(weather_data[:sunset].to_s,'%s').strftime("%Y/%m/%d %k:%M:%S %z"),
      temperature: fahrenheit(weather_data[:temp]),
      feels_like: fahrenheit(weather_data[:feels_like]),
      humidity: weather_data[:humidity],
      uvi: weather_data[:uvi],
      visibility: weather_data[:visibility],
      conditions: weather_data[:weather].first[:description],
      icon: weather_data[:weather].first[:icon]
    }
  end

  def daily_weather_for_5_days(weather_data)
    weather_data.first(5).map do |daily|
      DailyWeather.new(daily)
    end
  end

  def hourly_weather_for_8_hours(weather_data)
    weather_data.first(8).map do |hourly|
      HourlyWeather.new(hourly)
    end
  end

  def fahrenheit(temp)
    (temp - 273.15) * (9 / 5) + 32
  end
end
