require 'rails_helper'

describe GoogleApiService, :vcr do
  describe 'methods' do
    describe 'instance methods' do
      describe 'geocode' do
        it 'returns city, state, country, formatted city/state, lat, and long of location' do
          end_location_info = GoogleApiService.new.geocode('pueblo,co')
          expect(end_location_info).to include(
            city: 'Pueblo',
            state: 'CO',
            country: 'United States',
            city_state: 'Pueblo, CO',
            lat: 38.2544472,
            long: -104.6091409
          )
        end
      end
    end
  end
end
