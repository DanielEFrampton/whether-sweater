class Api::V1::MunchiesController < ApplicationController
  def show
    # Get necessary Google API info
    end_location_info = GoogleApiService.new.geocode(params[:end])
    distance_info = GoogleApiService.new.distance(params[:start], params[:end])

    # Calculate Unix timestamp of arrival time
    travel_seconds = distance_info['rows'][0]['elements'][0]['duration']['value']
    arrival_timestamp = Time.now.to_i + travel_seconds

    # Pull latitude and longitude from geocode info
    lat = end_location_info['results'][0]['geometry']['location']['lat']
    long = end_location_info['results'][0]['geometry']['location']['lng']

    # Get DarkSky forecast at given arrival time
    forecast_info = DarkSkyService.new.forecast(lat, long, arrival_timestamp)
    forecast = forecast_info['currently']['summary']

    # Get Yelp info on restaurant at end location open at timestamp
    restaurant_info = YelpService.new.restaurant_open_at(params[:food], arrival_timestamp)

    munchies = Munchies.new(params[:start], params[:end], params[:food])
    render json: MunchiesSerializer.new(munchies)
  end
end
