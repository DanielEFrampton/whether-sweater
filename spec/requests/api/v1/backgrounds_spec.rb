require 'rails_helper'

describe 'as a front-end developer', :vcr do
  describe 'when I send a get request to the backgrounds endpoint with a location' do
    before(:each) do
      get '/backgrounds?location=indianapolis,in'
      @response = JSON.parse(response.body)
      @image_url = @response['data']['attributes']['image_url']
    end

    it 'I receive a JSON:API response containing a background image url' do
      expect(@image_url).to be_an_instance_of String
      expect(@image_url.include?('https://images.unsplash.com/photo')).to eq(true)
    end
  end
end
