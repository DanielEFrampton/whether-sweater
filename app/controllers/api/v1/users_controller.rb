class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(strong_params)
    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: error(user), status: 400
    end
  end

  private

  def strong_params
    params.permit(:email, :password, :password_confirmation)
  end

  def error(object)
    generate_error(detail: error_details(object),
                   parameter: error_parameters(object),
                   title: 'Invalid Request')
  end

  def error_parameters(object)
    object.errors.map do |attribute, _error|
      attribute
    end.join(', ')
  end

  def error_details(object)
    object.errors.full_messages.join(', ') + '.'
  end
end
