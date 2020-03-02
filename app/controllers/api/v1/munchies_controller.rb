class Api::V1::MunchiesController < ApplicationController
  def show
    # Get Google Geocode API info
    end_location_info = GoogleApiService.new.geocode(params[:end])
    end_location = end_location_info['results'][0]['formatted_address']
    lat = end_location_info['results'][0]['geometry']['location']['lat']
    long = end_location_info['results'][0]['geometry']['location']['lng']

    # Get Google Distance Matrix API info (doesn't account for time zone)
    distance_info = GoogleApiService.new.distance(params[:start], params[:end])
    travel_time = distance_info['rows'][0]['elements'][0]['duration']['text']
    travel_seconds = distance_info['rows'][0]['elements'][0]['duration']['value']
    arrival_timestamp = Time.now.to_i + travel_seconds

    # Get DarkSky forecast at given arrival time
    forecast_info = DarkSkyService.new.forecast(lat, long, arrival_timestamp)
    forecast = forecast_info['currently']['summary']

    # Get Yelp info on restaurant at end location open at timestamp
    restaurant_info = YelpService.new.restaurant_open_at(lat, long, params[:food], arrival_timestamp)

    restaurant_name = restaurant_info['businesses'][0]['name']
    restaurant_address = restaurant_info['businesses'][0]['location']['display_address'].join(', ')

    munchies = Munchies.new(forecast, {name: restaurant_name, address: restaurant_address}, travel_time, end_location)
    render json: MunchiesSerializer.new(munchies)
  end
end
