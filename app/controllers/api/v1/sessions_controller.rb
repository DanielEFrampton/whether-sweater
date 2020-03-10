class Api::V1::SessionsController < ApplicationController
  def create
    if !user = User.find_by(email: params[:email])
      render json: error('email'), status: failure_status
    elsif user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    else
      render json: error('password'), status: failure_status
    end
  end

  private

  def failure_status
    400
  end

  def error(parameter)
    generate_error(detail: 'Invalid' + parameter,
                   title: 'Invalid Credentials',
                   parameter: parameter)
  end
end
