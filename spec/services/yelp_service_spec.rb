require 'rails_helper'

describe YelpService, :vcr do
  describe 'methods' do
    describe 'instance methods' do
      describe 'restaurant_open_at' do
        it 'returns name and address of restaurant of given type at location open at time' do
          restaurant_info = YelpService.new.restaurant_open_at(38.2544472,-104.6091409,'chinese',1583179426)
          expect(restaurant_info).to include(
            name: "Kan's Kitchen",
            address: '1620 S Prairie Ave, Pueblo, CO 81005'
          )
        end
      end
    end
  end
end
