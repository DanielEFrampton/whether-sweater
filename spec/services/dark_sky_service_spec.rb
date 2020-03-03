require 'rails_helper'

RSpec.describe DarkSkyService, :vcr do
  describe 'instance methods' do
    describe 'geocode' do
      it 'returns parsed JSON data from DarkSky API for given lat/long' do
        data = DarkSkyService.new.forecast('39.7392358','-104.990251')
        expect(data.class).to eq(Hash)
        expect(data.keys.include?('currently')).to eq(true)
        expect(data.keys.include?('offset')).to eq(true)
        expect(data.keys.include?('flags')).to eq(true)
        expect(data.keys.include?('daily')).to eq(true)
        expect(data.keys.include?('hourly')).to eq(true)
        expect(data.keys.include?('minutely')).to eq(true)
        expect(data.keys.include?('latitude')).to eq(true)
        expect(data.keys.include?('longitude')).to eq(true)
        expect(data.keys.include?('timezone')).to eq(true)
      end
    end

    describe 'simple_future_forecast' do
      it 'returns object initialized with temperature and summary of weather at future time at given lat/long' do
        data = DarkSkyService.new.simple_future_forecast('39.7392358','-104.990251',1583179830)
        expect(data).to be_instance_of(FutureForecastResults)
        expect(data.summary).to eq('Clear')
        expect(data.temperature).to eq(47.74)
      end
    end
  end
end
