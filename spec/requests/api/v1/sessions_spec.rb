require 'rails_helper'

describe 'as a front-end developer' do
  describe 'when I sent a post request to the sessions endpoint' do
    describe 'with a valid username and password' do
      before(:each) do
        @user = create(:user)
        post '/api/v1/sessions', params: {"email": @user.email,
                                          "password": "password"}
        @status_code = response.status
        @response = JSON.parse(response.body)
      end

      it 'I receive a JSON:API response with the API key for that user' do
        expect(@response).to include(
          'data' => {
            'id' => @user.id.to_s,
            'type' => 'user',
            'attributes' => {
              'api_key' => @user.api_key
            }
          }
        )
        expect(@user.api_key).to match(/[A-Za-z0-9]{24}/)
      end

      it 'I receive a status code of 200' do
        expect(@status_code).to eq(200)
      end
    end

    describe 'with an invalid username and/or password' do
      before(:each) do
        @user = create(:user)
        post '/api/v1/sessions', params: {"email": @user.email,
                                          "password": "wrong_password"}
        @status_code = response.status
        @response = JSON.parse(response.body)
      end

      it 'I receive a JSON:API response with a description of why it failed' do
        expect(@response).to include(
          'errors' => [
            "status" => "400",
            "source" => { "pointer" => "/api/v1/sessions", "parameter" => "wrong_password" },
            "title" =>  "Invalid Authentication",
            "detail" => "Invalid password."
          ]
        )
      end

      it "I receive a 400-level status code" do
        expect(@status_code).to eq(400)
      end
    end
  end
end
