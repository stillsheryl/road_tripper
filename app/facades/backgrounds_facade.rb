class BackgroundsFacade
  def self.get_photo(params)
    coordinates = GeocodingService.get_coordinates(params[:location])
    if coordinates[:status] == 400
      return_error(coordinates)
    else
      create_coordinates(coordinates, params)
    end
  end

  def self.create_coordinates(coordinates, params)
    city_coordinates = {}
    city_coordinates[:lat] = coordinates[:results].first[:locations].first[:latLng][:lat]
    city_coordinates[:long] = coordinates[:results].first[:locations].first[:latLng][:lng]

    check_weather(city_coordinates, params)
  end

  def self.check_weather(city_coordinates, params)
    weather_info = WeatherService.get_weather(city_coordinates)

    if weather_info[:status] == 400
      return_error(weather_info)
    else
      use_weather_to_create_photo(weather_info, params)
    end
  end

  def self.use_weather_to_create_photo(weather_info, params)
    weather = Weather.new(weather_info)
    current_weather = weather.current_weather[:conditions]
    photo_info = PhotoService.get_photo(params, current_weather)

    create_photo(photo_info, params)
  end

  def self.create_photo(photo_info, params)
    if photo_info[:total] != 0
      Photo.new(photo_info, params)
    else
      error_message = { error: 'Please provide a valid city for the search.', status: 400 }
      return_error(error_message)
    end
  end

  def self.return_error(error_message)
    error_message
  end
end
