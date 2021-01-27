class HourlyWeather
  attr_reader :time,
              :temperature,
              :wind_speed,
              :wind_direction,
              :conditions,
              :icon

  def initialize(weather_data)
    @time = DateTime.strptime(weather_data[:dt].to_s,'%s').strftime("%k:%M:%S")
    @temperature = KelvinConverter.fahrenheit(weather_data[:temp])
    @wind_speed = "#{weather_data[:wind_speed]} mph"
    @wind_direction = "from #{wind_direction_from_integer(weather_data[:wind_deg])}"
    @conditions = weather_data[:weather].first[:description]
    @icon = weather_data[:weather].first[:icon]
  end

  def wind_direction_from_integer(integer)
    val = (integer / 22.5) + (0.5)
    index = (val % 16)
    arr = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
    arr[index]
  end
end
