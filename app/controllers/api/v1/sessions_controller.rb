class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if !user
      status = 400
      render json: ErrorSerializer.new('Invalid email.', status, params[:email]).errors, status: status
    elsif user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    else
      status = 400
      render json: ErrorSerializer.new('Invalid password.', status, params[:password]).errors, status: status
    end
  end

  private

  def strong_params
    params.permit(:email, :password)
  end
end
