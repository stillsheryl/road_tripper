class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user != nil && user.authenticate(params[:password])
      session[:user_id] = user.id

      user_data = UserSerializer.new(user).to_json

      render json: user_data

    else
      error_message = { error: "Invalid email or password. Please try again.", status: 400 }

      render json: error_message, status: :bad_request
    end
  end
end
