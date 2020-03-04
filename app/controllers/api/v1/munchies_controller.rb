class Api::V1::MunchiesController < ApplicationController
  def show
    end_location = GoogleApiService.new.geocode(params[:end])
    distance = GoogleApiService.new.distance(params[:start], params[:end])
    forecast = DarkSkyService.new.future_forecast(end_location[:lat],
                                                  end_location[:long],
                                                  distance[:arrival_time])
    restaurant = YelpService.new.restaurant_open_at(end_location[:lat],
                                                    end_location[:long],
                                                    params[:food],
                                                    distance[:arrival_time])
    munchies = Munchies.new(forecast.summary,
                            restaurant,
                            distance[:travel_time],
                            end_location[:city_state])
    render json: MunchiesSerializer.new(munchies)
  end
end
