require 'rails_helper'

describe 'as a user' do
  describe 'when I send a request to munchies endpoint with start and end locations and food type' do
    before(:each) do
      get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese'
      parsed = JSON.parse(response.body)
      @attributes = parsed['data']['attributes']
    end

    it 'I receieve a JSON:API response with end location, travel time, forecast at arrival, and open restaurant' do
      expect(@attributes).to include(
        'end_location' => 'Pueblo, CO',
        'travel_time' => '1 hours 48 min',
        'forecast' => 'Cloudy with a chance of meatballs'
        'restaurant' => {
          'name' => 'Chinese Restaurant',
          'address' => '4602 N. Elizabeth St, Ste 120, Pueblo, CO 81008'
        }
      )
    end
  end
end
