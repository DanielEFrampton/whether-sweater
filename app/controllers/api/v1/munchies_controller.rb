class Api::V1::MunchiesController < ApplicationController
  def show
    end_location = GoogleApiService.new.geocode(params[:end])

    # Get Google Distance Matrix API info (doesn't account for time zone)
    distance_info = GoogleApiService.new.distance(params[:start], params[:end])
    travel_time = distance_info['rows'][0]['elements'][0]['duration']['text']
    travel_seconds = distance_info['rows'][0]['elements'][0]['duration']['value']
    arrival_timestamp = Time.now.to_i + travel_seconds

    forecast = DarkSkyService.new.simple_future_forecast(end_location[:lat], end_location[:long], arrival_timestamp)
    restaurant_info = YelpService.new.restaurant_open_at(end_location[:lat], end_location[:long], params[:food], arrival_timestamp)
    munchies = Munchies.new(forecast, restaurant_info, travel_time, end_location[:city_state])
    render json: MunchiesSerializer.new(munchies)
  end
end
