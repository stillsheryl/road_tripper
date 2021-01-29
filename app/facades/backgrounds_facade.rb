class BackgroundsFacade
  def self.get_photo(params)
    coordinates = GeocodingService.get_coordinates(params[:location])

    return error_message(params) if coordinates[:error] == true

    weather_info = WeatherService.get_weather(coordinates)

    return error_message(params) if weather_info[:error] == true

    photo_info = get_photo_info(weather_info, params)

    return error_message(params) if photo_info[:total] == 0

    Photo.new(photo_info, params)
  end

  def self.get_photo_info(weather_info, params)
    weather = Weather.new(weather_info)
    current_weather = weather.current_weather[:conditions]
    PhotoService.get_photo(params, current_weather)
  end

  def self.error_message(params)
    { message: "Unknown Location: #{params[:location]}. Please provide a valid city.", status: 400 }
  end
end
