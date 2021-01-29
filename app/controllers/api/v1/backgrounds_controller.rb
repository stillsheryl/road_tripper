class Api::V1::BackgroundsController < ApplicationController
  def index
    image_or_error = BackgroundsFacade.get_photo(params)

    if image_or_error.is_a? Photo
      output = PhotoSerializer.new(image_or_error).to_json
      render json: output

    else
      render json: image_or_error, status: 400
    end
  end
end
