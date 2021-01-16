class HourlyWeather
  attr_reader :time,
              :temperature,
              :wind_speed,
              :wind_direction,
              :conditions,
              :icon,
              :id

  def initialize(weather_data)
    @time = Date.strptime(weather_data[:dt].to_s,'%s').strftime("%k:%M:%S")
    @temperature = weather_data[:temp]
    @wind_speed = weather_data[:wind_speed]
    @wind_direction = weather_data[:wind_deg]
    @conditions = weather_data[:weather].first[:description]
    @icon = weather_data[:weather].first[:icon]
    @id = nil
  end
end
