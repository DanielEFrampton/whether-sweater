require 'rails_helper'

describe 'as a front-end developer', :vcr do
  describe 'when I send a post request to the road_trip endpoint' do
    describe 'with valid API key' do
      before(:each) do
        allow(Time).to receive(:now).and_return(Time.parse('2020-03-03 13:31:31 -0700'))
        post '/api/v1/road_trip', params: {"origin": "Denver,CO",
                                           "destination": "Pueblo,CO",
                                           "api_key": "jgn983hy48thw9begh98h4539h4"}
        @status_code = response.status
        @response = JSON.parse(response.body)
      end

      it 'I receive a 201 status code response' do
        expect(@status_code).to eq(201)
      end

      it 'I receive a JSON:API response containing origin, destination, travel time, and arrival forecast info' do
        expect(@response).to include(
          'data' => {
            'id' => nil,
            'type' => 'roadTrip',
            'attributes' => {
              'origin' => 'Denver, CO',
              'destination' => 'Pueblo, CO',
              'travelTime' => '1 hour 48 mins',
              'forecast' => {
                'temperature' => 61.4,
                'summary' => 'Clear'
              }
            }
          }
        )
      end
    end

    describe 'with an invalid or no API key' do
      it 'I receive a JSON:API error object with descriptive error information' do
        allow(Time).to receive(:now).and_return(Time.parse('2020-03-03 13:31:31 -0700'))
        post '/api/v1/road_trip', params: {"origin": "Denver,CO",
                                           "destination": "Pueblo,CO",
                                           "api_key": "aaaabbbbccccddddeeeeffff"}
        status_code_1 = response.status
        response_1 = JSON.parse(response.body)

        expect(status_code_1).to eq(401)
        expect(response_1).to include(
          'errors' => [
            "status" => "401",
            "source" => { "pointer" => "/api/v1/road_trip", "parameter" => "api_key" },
            "title" =>  "Unauthorized Request",
            "detail" => "The API key provided was invalid."
          ]
        )

        post '/api/v1/road_trip', params: {"origin": "Denver,CO",
                                           "destination": "Pueblo,CO"}
        status_code_2 = response.status
        response_2 = JSON.parse(response.body)

        expect(status_code_2).to eq(401)
        expect(response_2).to include(
          'errors' => [
            "status" => "401",
            "source" => { "pointer" => "/api/v1/road_trip", "parameter" => "api_key" },
            "title" =>  "Unauthorized Request",
            "detail" => "No API key was provided."
          ]
        )
      end
    end
  end
end
