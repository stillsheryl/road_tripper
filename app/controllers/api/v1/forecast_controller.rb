class Api::V1::ForecastController < ApplicationController
  def index
    weather = ForecastFacade.get_forecast(params)

    if weather.is_a? Weather
      output = WeatherSerializer.new(weather).to_json

      render json: output
    else
      render json: weather, status: 400
    end
  end
end
