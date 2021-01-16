class Api::V1::ForecastController < ApplicationController
  def index
    city_coordinates = GeocodingFacade.coordinates(params)

    weather = WeatherFacade.weather(city_coordinates)

    WeatherSerializer.new(weather).to_json
  end
end
