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
    @temperature = fahrenheit(weather_data[:temp])
    @wind_speed = "#{weather_data[:wind_speed]} mph"
    @wind_direction = "from #{wind_direction_from_integer(weather_data[:wind_deg])}"
    @conditions = weather_data[:weather].first[:description]
    @icon = weather_data[:weather].first[:icon]
    @id = nil
  end

  def wind_direction_from_integer(integer)
    val = (integer / 22.5) + (0.5)
    index = (val % 16)
    arr = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
    arr[index]
  end

  def fahrenheit(temp)
    (temp - 273.15) * (9 / 5) + 32
  end
end
