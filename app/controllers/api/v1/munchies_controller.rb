class Api::V1::MunchiesController < ApplicationController
  def show
    end_location = GoogleApiService.new.geocode(params[:end])
    distance_info = GoogleApiService.new.distance(params[:start], params[:end])
    forecast_results = DarkSkyService.new.simple_future_forecast(end_location[:lat], end_location[:long], distance_info[:arrival_timestamp])
    restaurant_info = YelpService.new.restaurant_open_at(end_location[:lat], end_location[:long], params[:food], distance_info[:arrival_timestamp])
    munchies = Munchies.new(forecast_results.summary, restaurant_info, distance_info[:travel_time], end_location[:city_state])
    render json: MunchiesSerializer.new(munchies)
  end
end
