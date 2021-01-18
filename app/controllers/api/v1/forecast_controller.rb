class Api::V1::ForecastController < ApplicationController
  def index
    city_coordinates = GeocodingFacade.coordinates(params[:location])

    if city_coordinates[:status] == 400
      render json: city_coordinates, status: 400
    else
      weather = WeatherFacade.weather(city_coordinates)

      output = WeatherSerializer.new(weather).to_json

      render json: output
    end
  end
end
