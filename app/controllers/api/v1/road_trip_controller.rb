class Api::V1::RoadTripController < ApplicationController
  def create
    if User.find_by(api_key: params[:api_key]) != nil
      roadtrip = RoadTripFacade.roadtrip_data(params)

      output = RoadtripSerializer.new(roadtrip).to_json

      render json: output
    else
      error_message = { error: 'A valid API key is required.', status: 401 }

      render json: error_message, status: 401
    end
  end
end
