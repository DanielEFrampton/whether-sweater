require 'rails_helper'

describe ForecastFacade do
  describe 'instance methods' do
    describe 'tonight_summary' do
      it 'should return weather summary of 9pm hour if before 9pm, or current hour if after 9pm but before midnight' do
        location_info = JSON.parse(file_fixture('denver_geocode.json').read)
        weather_info_1 = JSON.parse(file_fixture('denver_forecast_3.json').read)

        forecast_1 = ForecastFacade.new(weather: weather_info_1, geocode: location_info) # 10 o'clock current time
        expect(forecast_1.tonight_summary).to eq("The currently summary")

        weather_info_2 = JSON.parse(file_fixture('denver_forecast_2.json').read)
        forecast_2 = ForecastFacade.new(weather: weather_info_2, geocode: location_info) # 3 o'clock current time
        expect(forecast_2.tonight_summary).to eq("The 9 o'clock summary")

        weather_info_3 = JSON.parse(file_fixture('denver_forecast_4.json').read)
        forecast_3 = ForecastFacade.new(weather: weather_info_3, geocode: location_info) # 12:01am current time
        expect(forecast_3.tonight_summary).to eq("The 9pm summary")
      end
    end
  end
end
