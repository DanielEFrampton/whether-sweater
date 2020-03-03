class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(strong_params)
    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: ErrorSerializer.new(detail: user.errors.full_messages.join(', ').concat('.'),
                                       title: 'Invalid Request',
                                       status: registration_failure_status,
                                       pointer: request.env['PATH_INFO'],
                                       parameter: error_parameters(user)).errors, status: registration_failure_status
    end
  end

  private

    def strong_params
      params.permit(:email, :password, :password_confirmation)
    end

    def registration_failure_status
      400
    end

    def error_parameters(object)
      object.errors.map do |attribute, _error|
        attribute
      end.join(', ')
    end
end
