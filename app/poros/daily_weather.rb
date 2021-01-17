class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(weather_data)
    @date = Date.strptime(weather_data[:dt].to_s,'%s').strftime("%Y/%m/%d")
    @sunrise = DateTime.strptime(weather_data[:sunrise].to_s,'%s').strftime("%Y/%m/%d %k:%M:%S")
    @sunset = DateTime.strptime(weather_data[:sunset].to_s,'%s').strftime("%Y/%m/%d %k:%M:%S")
    @max_temp = fahrenheit(weather_data[:temp][:max])
    @min_temp = fahrenheit(weather_data[:temp][:min])
    @conditions = weather_data[:weather].first[:description]
    @icon = weather_data[:weather].first[:icon]
  end

  def fahrenheit(temp)
    (temp - 273.15) * (9 / 5) + 32
  end
end
