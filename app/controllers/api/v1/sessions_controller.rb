class Api::V1::SessionsController < ApplicationController
  def create
    if User.find_by(email: params[:email]).none?
      render json: ErrorSerializer.new(pointer: request.env['PATH_INFO'], title: 'Invalid Credentials', detail: 'Invalid email.', status: credential_failure_status, parameter: 'email').errors, status: credential_failure_status
    elsif user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    else
      render json: ErrorSerializer.new(pointer: request.env['PATH_INFO'], title: 'Invalid Credentials', detail: 'Invalid password.', status: credential_failure_status, parameter: 'password').errors, status: credential_failure_status
    end
  end

  private

  def strong_params
    params.permit(:email, :password)
  end

  def credential_failure_status
    400
  end
end
