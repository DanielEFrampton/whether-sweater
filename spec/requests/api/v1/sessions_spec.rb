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
      it 'I receive a JSON:API response with a description of why it failed and 400 status code' do
        user_1 = create(:user)
        post '/api/v1/sessions', params: {"email": user_1.email,
          "password": "wrong_password"}
        status_code_1 = response.status
        response_1 = JSON.parse(response.body)

        expect(status_code_1).to eq(400)
        expect(response_1).to include(
          'errors' => [
            "status" => "400",
            "source" => { "pointer" => "/api/v1/sessions", "parameter" => "password" },
            "title" =>  "Invalid Credentials",
            "detail" => "Invalid password."
          ]
        )

        user_2 = create(:user, email: 'the@right.email')
        post '/api/v1/sessions', params: {"email": 'not@theright.email',
          "password": "password"}
        status_code_2 = response.status
        response_2 = JSON.parse(response.body)

        expect(status_code_2).to eq(400)
        expect(response_2).to include(
          'errors' => [
            "status" => "400",
            "source" => { "pointer" => "/api/v1/sessions", "parameter" => "email" },
            "title" =>  "Invalid Credentials",
            "detail" => "Invalid email."
          ]
        )
      end
    end
  end
end
