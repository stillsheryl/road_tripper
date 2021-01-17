require 'securerandom'

class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params) do |user|
      user.email = user_params[:email]
      user.password_digest = user_params[:password]
      user.api_key = SecureRandom.uuid
    end

    if user.save
      params = new_user_params(user_params, user)
      user_obj = User.new(params)
      output = UserSerializer.new(user_obj).to_json
      render json: output, status: :created
    else
      error_message = {
        error: user.errors.full_messages.to_sentence,
        status: 400
      }

      render json: error_message, status: :bad_request
      return
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def new_user_params(user_params, user)
    new_params = {}
    new_params[:email] = user_params[:email]
    new_params[:api_key] = user.api_key
    new_params
  end
end
