class Api::V1::ForecastController < ApplicationController
  def index
    city_coordinates = GeocodingFacade.coordinates(params[:location])

    weather = WeatherFacade.weather(city_coordinates)
  end
end
