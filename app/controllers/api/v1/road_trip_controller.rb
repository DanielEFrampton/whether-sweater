class Api::V1::RoadTripController < ApplicationController
  def create
    if !params[:api_key]
      status = 401
      render json: Error.new(title: 'Unauthorized Request',
                             detail: 'No API key was provided.',
                             status: status,
                             parameter: 'api_key',
                             pointer: request.env['PATH_INFO']).errors,
             status: status
    elsif User.authenticate_token(params[:api_key])
      end_location = GoogleApiService.new.geocode(params[:destination])
      distance = GoogleApiService.new.distance(params[:origin],
                                               params[:destination])
      forecast = DarkSkyService.new.future_forecast(end_location[:lat],
                                                    end_location[:long],
                                                    distance[:arrival_time])
      road_trip = RoadTrip.new(forecast: forecast,
                               travel_time: distance[:travel_time],
                               origin: city_state(params[:origin]),
                               destination: city_state(params[:destination]))
      render json: RoadTripSerializer.new(road_trip), status: 201
    else
      status = 401
      render json: Error.new(title: 'Unauthorized Request',
                             detail: 'The API key provided was invalid.',
                             status: status,
                             parameter: 'api_key',
                             pointer: request.env['PATH_INFO']).errors,
             status: status
    end
  end

  private

  def city_state(string)
    string.gsub(',', ', ')
  end
end
