class Api::V1::BackgroundsController < ApplicationController
  def index
    image = PhotoFacade.photo(params)

    if image.is_a? Photo
      output = PhotoSerializer.new(image).to_json
      render json: output

    else
      render json: image, status: 400
    end
  end
end
