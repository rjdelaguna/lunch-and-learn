class Api::V1::UsersController < ApplicationController
  def create
    new_user = User.new(user_params)
    if new_user.save
      render json: UserSerializer.new(new_user)
    elsif params[:password] != params[:password_confirmation]
      render json: ErrorSerializer.new(ErrorMessage.new(new_user.errors.full_messages, "401")), status: :unauthorized
    else
      render json: ErrorSerializer.new(ErrorMessage.new("Credentials Invalid", "401")), status: :unauthorized
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if !user || !user.authenticate(params[:password])
      render json: ErrorSerializer.new(ErrorMessage.new("Credentials Invalid", "401")), status: :unauthorized
    else
      render json: UserSerializer.new(user)
    end
  end

  private

  def user_params
    info = params.permit(:name, :email, :password, :password_confirmation)
    info[:api_key] = SecureRandom.hex
    info
  end
end