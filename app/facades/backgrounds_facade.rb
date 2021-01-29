class BackgroundsFacade
  def self.get_photo(params)
    coordinates = GeocodingService.get_coordinates(params[:location])

    return coordinates if coordinates[:status] == 400

    weather_info = get_weather(coordinates)

    return weather_info if weather_info[:status] == 400

    photo_info = get_photo_info(weather_info, params)

    return { error: 'Please provide a valid city for the search.', status: 400 } if photo_info[:total] == 0

    Photo.new(photo_info, params)
  end

  def self.get_weather(coordinates)
    WeatherService.get_weather(coordinates)
  end

  def self.get_photo_info(weather_info, params)
    weather = Weather.new(weather_info)
    current_weather = weather.current_weather[:conditions]
    PhotoService.get_photo(params, current_weather)
  end
end
