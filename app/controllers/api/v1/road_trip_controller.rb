class Api::V1::RoadTripController < ApplicationController
  def create
    end_location = GoogleApiService.new.geocode(params[:destination])
    distance_info = GoogleApiService.new.distance(params[:origin], params[:destination])
    forecast_info = DarkSkyService.new.simple_future_forecast(end_location[:lat], end_location[:long], distance_info[:arrival_timestamp])
    summary = forecast_info['currently']['summary']
    temp = forecast_info['currently']['temperature']
    forecast = FutureForecast.new(summary, temp)
    road_trip = RoadTrip.new(forecast: forecast,
                             travel_time: distance_info[:travel_time],
                             origin: format_location(params[:origin]),
                             destination: format_location(params[:destination]))
    render json: RoadTripSerializer.new(road_trip), status: 201
  end

  private

  def strong_params
    params.permit(:origin, :destination)
  end

  def format_location(string)
    string.gsub(',',', ')
  end
end
