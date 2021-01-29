class Api::V1::ForecastController < ApplicationController
  def index
    weather_or_error = ForecastFacade.get_forecast(params)

    if weather_or_error.is_a? Weather
      output = WeatherSerializer.new(weather_or_error).to_json

      render json: output
    else
      render json: weather_or_error, status: 400
    end
  end
end
