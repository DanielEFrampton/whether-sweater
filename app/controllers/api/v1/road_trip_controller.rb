class Api::V1::RoadTripController < ApplicationController
  def create
    if !params[:api_key]
      render json: generate_error('No API key was provided.'),
             status: request_failure_status
    elsif User.authenticate_token(params[:api_key])
      road_trip = RoadTrip.new(strong_params)
      render json: RoadTripSerializer.new(road_trip), status: 201
    else
      render json: generate_error('The API key provided was invalid.'),
             status: request_failure_status
    end
  end

  private

  def strong_params
    params.permit(:origin, :destination)
  end

  def request_failure_status
    401
  end

  def generate_error(detail)
    Error.new(title: 'Unauthorized Request',
              detail: detail,
              status: request_failure_status,
              parameter: 'api_key',
              pointer: request.env['PATH_INFO']).errors
  end
end
