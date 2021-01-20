class BackgroundsFacade
  def self.get_photo(params)
    coordinates = GeocodingService.get_coordinates(params[:location])
    city_coordinates = {}

    if coordinates[:status] == 400
      coordinates
    else
      city_coordinates[:lat] = coordinates[:results].first[:locations].first[:latLng][:lat]
      city_coordinates[:long] = coordinates[:results].first[:locations].first[:latLng][:lng]

      if city_coordinates[:status] == 400
        current_weather = ""
      else
        weather_info = WeatherService.get_weather(city_coordinates)

        if weather_info[:status] == 400
          weather_info
        else
          weather = Weather.new(weather_info)
          current_weather = weather.current_weather[:conditions]
          photo_info = PhotoService.get_photo(params, current_weather)

          if photo_info[:total] != 0
            Photo.new(photo_info, params)
          else
            { error: 'Please provide a valid city for the search.', status: 400 }
          end
        end
      end
    end
  end
end
