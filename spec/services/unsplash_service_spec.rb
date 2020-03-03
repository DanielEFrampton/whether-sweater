require 'rails_helper'

describe UnsplashService, :vcr do
  describe 'methods' do
    describe 'instance methods' do
      describe 'background' do
        it 'returns a background object containing image url for location' do
          background = UnsplashService.new.background('indianapolis,in')
          expect(background).to be_an_instance_of(Background)
          expect(background.image_url).to be_an_instance_of(String)
          expect(background.image_url.include?('https://images.unsplash.com/photo')).to eq(true)
        end
      end
    end
  end
end
