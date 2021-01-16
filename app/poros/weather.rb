class Weather
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather,
              :id

  def initialize(weather_data)
    @current_weather = current_weather_hash(weather_data)
    @daily_weather = daily_weather_for_5_days(weather_data[:daily])
    @hourly_weather = hourly_weather_for_8_hours(weather_data[:hourly])
    @id = nil
  end

  def current_weather_hash(weather_data)
    {
      datetime: DateTime.strptime(weather_data[:current][:dt].to_s,'%s'),
      sunrise: DateTime.strptime(weather_data[:current][:sunrise].to_s,'%s'),
      sunset: DateTime.strptime(weather_data[:current][:sunset].to_s,'%s'),
      temperature: weather_data[:current][:temp],
      feels_like: weather_data[:current][:feels_like],
      humidity: weather_data[:current][:humidity],
      uvi: weather_data[:current][:uvi],
      visibility: weather_data[:current][:visibility],
      conditions: weather_data[:current][:weather].first[:description],
      icon: weather_data[:current][:weather].first[:icon]
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
end
