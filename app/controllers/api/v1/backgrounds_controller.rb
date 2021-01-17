class Api::V1::BackgroundsController < ApplicationController
  def index
    image = PhotoFacade.photo(params)

    output = PhotoSerializer.new(image).to_json

    render json: output
  end
end
