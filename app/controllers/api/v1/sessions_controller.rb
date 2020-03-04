class Api::V1::SessionsController < ApplicationController
  def create
    if !user = User.find_by(email: params[:email])
      render json: generate_error('Invalid email.', 'email'),
             status: credential_failure_status
    elsif user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    else
      render json: generate_error('Invalid password.', 'password'),
             status: credential_failure_status
    end
  end

  private

  def credential_failure_status
    400
  end

  def generate_error(detail, parameter)
    Error.new(pointer: request.env['PATH_INFO'],
              title: 'Invalid Credentials',
              detail: detail,
              status: credential_failure_status,
              parameter: parameter).errors
  end
end
