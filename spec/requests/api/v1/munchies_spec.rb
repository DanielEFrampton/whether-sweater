require 'rails_helper'

describe 'as a user', :vcr do
  describe 'when I send a request to munchies endpoint with start and end locations and food type' do
    before(:each) do
      get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese'
      parsed = JSON.parse(response.body)
      @attributes = parsed['data']['attributes']
    end

    it 'I receieve a JSON:API response with end location, travel time, forecast at arrival, and open restaurant' do
      expect(@attributes).to include(
        'end_location' => 'Pueblo, CO, USA',
        'travel_time' => '1 hour 48 mins',
        'forecast' => 'Clear',
        'restaurant' => {
          'name' => "Kan's Kitchen",
          'address' => '1620 S Prairie Ave, Pueblo, CO 81005'
        }
      )
    end
  end
end
