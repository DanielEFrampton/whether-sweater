class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(strong_params)
    if user.save
      render json: UserSerializer.new(user)
    else
      render status: 400
    end
  end

  private

  def strong_params
    params.permit(:email, :password, :password_confirmation)
  end
end
