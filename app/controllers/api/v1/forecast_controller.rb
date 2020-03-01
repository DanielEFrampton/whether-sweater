class Api::V1::ForecastController < ApplicationController
  def show
    forecast = Forecast.new
    render json: ForecastSerializer.new(forecast)
  end
end
