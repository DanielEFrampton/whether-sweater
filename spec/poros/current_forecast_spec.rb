require 'rails_helper'

describe CurrentForecast do
  describe 'instance methods' do
    describe 'uv_exposure_category' do
      it 'returns exposure category matching uv index attribute' do
        arguments = {:current_data=>
                      {:time=>1583298194,
                       :summary=>"The currently summary",
                       :icon=>"clear-night",
                       :temperature=>37.42,
                       :apparentTemperature=>33.05,
                       :humidity=>0.47,
                       :cloudCover=>0,
                       :uvIndex=>3},
                     :today_data=>
                      {:time=>1583218800,
                       :summary=>"Clear throughout the day.",
                       :icon=>"clear-day",
                       :temperatureHigh=>62.04,
                       :temperatureLow=>26.91,
                       :humidity=>0.34,
                       :uvIndex=>5,
                       :visibility=>10
                     },
                     :offset=>-7,
                     :timezone=>"America/Denver"
                   }

        expect(arguments[:current_data][:uvIndex]).to eq(3)
        forecast = CurrentForecast.new(arguments)
        expect(forecast.uv_exposure_category).to eq('moderate')
        arguments[:current_data][:uvIndex] = 0
        forecast = CurrentForecast.new(arguments)
        expect(forecast.uv_exposure_category).to eq('low')
        arguments[:current_data][:uvIndex] = 1
        forecast = CurrentForecast.new(arguments)
        expect(forecast.uv_exposure_category).to eq('low')
        arguments[:current_data][:uvIndex] = 2
        forecast = CurrentForecast.new(arguments)
        expect(forecast.uv_exposure_category).to eq('low')
        arguments[:current_data][:uvIndex] = 4
        forecast = CurrentForecast.new(arguments)
        expect(forecast.uv_exposure_category).to eq('moderate')
        arguments[:current_data][:uvIndex] = 5
        forecast = CurrentForecast.new(arguments)
        expect(forecast.uv_exposure_category).to eq('moderate')
        arguments[:current_data][:uvIndex] = 6
        forecast = CurrentForecast.new(arguments)
        expect(forecast.uv_exposure_category).to eq('high')
        arguments[:current_data][:uvIndex] = 7
        forecast = CurrentForecast.new(arguments)
        expect(forecast.uv_exposure_category).to eq('high')
        arguments[:current_data][:uvIndex] = 8
        forecast = CurrentForecast.new(arguments)
        expect(forecast.uv_exposure_category).to eq('very high')
        arguments[:current_data][:uvIndex] = 9
        forecast = CurrentForecast.new(arguments)
        expect(forecast.uv_exposure_category).to eq('very high')
        arguments[:current_data][:uvIndex] = 10
        forecast = CurrentForecast.new(arguments)
        expect(forecast.uv_exposure_category).to eq('very high')
        arguments[:current_data][:uvIndex] = 11
        forecast = CurrentForecast.new(arguments)
        expect(forecast.uv_exposure_category).to eq('extreme')
        arguments[:current_data][:uvIndex] = 50
        forecast = CurrentForecast.new(arguments)
        expect(forecast.uv_exposure_category).to eq('extreme')
      end
    end
  end
end
