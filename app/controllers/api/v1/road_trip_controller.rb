class Api::V1::RoadTripController < ApplicationController
  def create
    if !params[:api_key]
      render json: error('No API key was provided.'), status: failure_status
    elsif User.authenticate_token(params[:api_key])
      road_trip = RoadTrip.new(strong_params)
      render json: RoadTripSerializer.new(road_trip), status: 201
    else
      render json: error('The API key provided was invalid.'),
             status: failure_status
    end
  end

  private

  def strong_params
    params.permit(:origin, :destination)
  end

  def failure_status
    401
  end

  def error(detail)
    generate_error(detail: detail,
                   title: 'Unauthorized Request',
                   parameter: 'api_key',
                   status: failure_status)
  end
end
