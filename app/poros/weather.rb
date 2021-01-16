class Weather
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon,
              :daily_weather

  def initialize(weather_data)
    @datetime = DateTime.strptime(weather_data[:current][:dt].to_s,'%s')
    @sunrise = DateTime.strptime(weather_data[:current][:sunrise].to_s,'%s')
    @sunset = DateTime.strptime(weather_data[:current][:sunset].to_s,'%s')
    @temperature = weather_data[:current][:temp]
    @feels_like = weather_data[:current][:feels_like]
    @humidity = weather_data[:current][:humidity]
    @uvi = weather_data[:current][:uvi]
    @visibility = weather_data[:current][:visibility]
    @conditions = weather_data[:current][:weather].first[:description]
    @icon = weather_data[:current][:weather].first[:icon]

    @daily_weather = daily_weather_for_5_days(weather_data)
  end

  def daily_weather_for_5_days(weather_data)
    weather_data[:daily].map do |daily|
      daily
      # @daily_date = daily[:dt]
      # @daily_sunrise = daily[:sunrise]
      # @daily_sunset = daily[:sunset]
      # @daily_max_temp = daily[:temp][:max]
      # @daily_min_temp = daily[:temp][:min]
      # @daily_conditions = daily[:weather][:description]
      # @daily_icon = daily[:weather][:icon]
    end
  end
end
