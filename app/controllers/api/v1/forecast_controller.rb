class Api::V1::ForecastController < ApplicationController
  def show
    location_info = GoogleApiService.new.geocode(params[:location])
    lat = location_info['results'][0]['geometry']['location']['lat']
    long = location_info['results'][0]['geometry']['location']['lng']
    weather_info = DarkSkyService.new.forecast(lat, long)
    forecast = Forecast.new(weather_info, location_info)
    render json: ForecastSerializer.new(forecast)
  end
end
