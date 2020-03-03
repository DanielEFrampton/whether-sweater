require 'rails_helper'

describe Forecast do
  describe 'instance methods' do
    describe 'tonight_summary' do
      it 'should return weather summary of 9pm hour if before 9pm, or current hour if after 9pm but before midnight' do
        location_info = JSON.parse(file_fixture('denver_geocode.json').read)
        weather_info_1 = JSON.parse(file_fixture('denver_forecast_3.json').read)

        forecast_1 = Forecast.new(weather_info_1, location_info) # 10 o'clock current time
        expect(forecast_1.tonight_summary).to eq("The currently summary")

        weather_info_2 = JSON.parse(file_fixture('denver_forecast_2.json').read)
        forecast_2 = Forecast.new(weather_info_2, location_info) # 3 o'clock current time
        expect(forecast_2.tonight_summary).to eq("The 9 o'clock summary")

        weather_info_3 = JSON.parse(file_fixture('denver_forecast_4.json').read)
        forecast_3 = Forecast.new(weather_info_3, location_info) # 12:01am current time
        expect(forecast_3.tonight_summary).to eq("The 9pm summary")
      end
    end

    describe 'hourly_forecasts' do
    end

    describe 'daily_forecasts' do
    end

    describe 'uv_exposure_category' do
      it 'returns exposure category matching uv index attribute' do
        location_info = JSON.parse(file_fixture('denver_geocode.json').read)
        weather_info = JSON.parse(file_fixture('denver_forecast.json').read)

        expect(weather_info['currently']['uvIndex']).to eq(3)
        forecast = Forecast.new(weather_info, location_info)
        expect(forecast.uv_exposure_category).to eq('moderate')
        weather_info['currently']['uvIndex'] = 0
        forecast = Forecast.new(weather_info, location_info)
        expect(forecast.uv_exposure_category).to eq('low')
        weather_info['currently']['uvIndex'] = 1
        forecast = Forecast.new(weather_info, location_info)
        expect(forecast.uv_exposure_category).to eq('low')
        weather_info['currently']['uvIndex'] = 2
        forecast = Forecast.new(weather_info, location_info)
        expect(forecast.uv_exposure_category).to eq('low')
        weather_info['currently']['uvIndex'] = 4
        forecast = Forecast.new(weather_info, location_info)
        expect(forecast.uv_exposure_category).to eq('moderate')
        weather_info['currently']['uvIndex'] = 5
        forecast = Forecast.new(weather_info, location_info)
        expect(forecast.uv_exposure_category).to eq('moderate')
        weather_info['currently']['uvIndex'] = 6
        forecast = Forecast.new(weather_info, location_info)
        expect(forecast.uv_exposure_category).to eq('high')
        weather_info['currently']['uvIndex'] = 7
        forecast = Forecast.new(weather_info, location_info)
        expect(forecast.uv_exposure_category).to eq('high')
        weather_info['currently']['uvIndex'] = 8
        forecast = Forecast.new(weather_info, location_info)
        expect(forecast.uv_exposure_category).to eq('very high')
        weather_info['currently']['uvIndex'] = 9
        forecast = Forecast.new(weather_info, location_info)
        expect(forecast.uv_exposure_category).to eq('very high')
        weather_info['currently']['uvIndex'] = 10
        forecast = Forecast.new(weather_info, location_info)
        expect(forecast.uv_exposure_category).to eq('very high')
        weather_info['currently']['uvIndex'] = 11
        forecast = Forecast.new(weather_info, location_info)
        expect(forecast.uv_exposure_category).to eq('extreme')
        weather_info['currently']['uvIndex'] = 50
        forecast = Forecast.new(weather_info, location_info)
        expect(forecast.uv_exposure_category).to eq('extreme')
      end
    end
  end
end
