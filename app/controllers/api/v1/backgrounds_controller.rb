class Api::V1::BackgroundsController < ApplicationController
  def index
    city_coordinates = GeocodingFacade.coordinates(params[:location])

    if city_coordinates[:status] == 400
      current_weather = ""
    else
      weather = WeatherFacade.weather(city_coordinates)
      current_weather = weather.current_weather[:conditions]
    end

    image = PhotoFacade.photo(params, current_weather)

    if image.is_a? Photo
      output = PhotoSerializer.new(image).to_json
      render json: output

    else
      render json: image, status: 400
    end
  end
end
