class Api::V1::RoadTripController < ApplicationController
  def create
    if !params[:api_key]
      status = 401
      render json: ErrorSerializer.new(title: 'Unauthorized Request', detail: 'No API key was provided.', status: status, parameter: 'api_key', pointer: request.env['PATH_INFO']).errors, status: status
    elsif User.authenticate_token(params[:api_key])
      end_location = GoogleApiService.new.geocode(params[:destination])
      distance_info = GoogleApiService.new.distance(params[:origin], params[:destination])
      forecast_results = DarkSkyService.new.simple_future_forecast(end_location[:lat], end_location[:long], distance_info[:arrival_timestamp])
      road_trip = RoadTrip.new(forecast: forecast_results,
                               travel_time: distance_info[:travel_time],
                               origin: format_location(params[:origin]),
                               destination: format_location(params[:destination]))
      render json: RoadTripSerializer.new(road_trip), status: 201
    else
      status = 401
      render json: ErrorSerializer.new(title: 'Unauthorized Request', detail: 'The API key provided was invalid.', status: status, parameter: 'api_key', pointer: request.env['PATH_INFO']).errors, status: status
    end
  end

  private

  def format_location(string)
    string.gsub(',', ', ')
  end
end
