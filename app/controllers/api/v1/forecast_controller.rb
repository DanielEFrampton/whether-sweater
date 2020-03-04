class Api::V1::ForecastController < ApplicationController
  def show
    geocode = GoogleApiService.new.geocode(params[:location])
    weather = DarkSkyService.new.forecast(geocode[:lat], geocode[:long])
    forecast = ForecastFacade.new(weather: weather, geocode: geocode)
    render json: ForecastSerializer.new(forecast)
  end
end
