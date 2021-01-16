class DailyWeather
  attr_reader :daily_date,
              :daily_sunrise,
              :daily_sunset,
              :daily_max_temp,
              :daily_min_temp,
              :daily_conditions,
              :daily_icon,
              :id

  def initialize(weather_data)
    @date = Date.strptime(weather_data[:dt].to_s,'%s').strftime("%Y/%m/%d")
    @sunrise = DateTime.strptime(weather_data[:sunrise].to_s,'%s')
    @sunset = DateTime.strptime(weather_data[:sunset].to_s,'%s')
    @max_temp = weather_data[:temp][:max]
    @min_temp = weather_data[:temp][:min]
    @conditions = weather_data[:weather].first[:description]
    @icon = weather_data[:weather].first[:icon]
    @id = nil
  end
end
