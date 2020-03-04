class Api::V1::ForecastController < ApplicationController
  def show
    location_info = GoogleApiService.new.geocode(params[:location])
    weather_info = DarkSkyService.new.forecast(location_info[:lat],
                                               location_info[:long])
    forecast = Forecast.new(weather_info, location_info)
    render json: ForecastSerializer.new(forecast)
  end
end
