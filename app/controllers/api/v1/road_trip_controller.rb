class Api::V1::RoadTripController < ApplicationController
  def create
    if User.find_by(api_key: params[:api_key]) != nil
      driving_time = DirectionsFacade.directions_time(params)

      city_coordinates = GeocodingFacade.coordinates(params[:destination])

      weather = WeatherFacade.weather_at_time(params, city_coordinates, driving_time)

      roadtrip = Roadtrip.new(weather)

      output = RoadtripSerializer.new(roadtrip).to_json

      render json: output, status: :created
    else
      error_message = {
        error: 'Unauthorized User. Please login to plan a trip.',
        status: 401
      }

      render json: error_message, status: :unauthorized_user
    end
  end
end
