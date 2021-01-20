require 'securerandom'

class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params) do |user|
      user.api_key = SecureRandom.uuid
    end

    if user.save
      output = UserSerializer.new(user).to_json

      render json: output, status: :created
    else
      error_message = { error: user.errors.full_messages.to_sentence, status: 400 }

      render json: error_message, status: :bad_request
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
