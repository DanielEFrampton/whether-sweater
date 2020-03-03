require 'rails_helper'

describe 'as a front-end developer' do
  describe 'when I send a post request to the users endpoint with email, password, and password confirmation' do
    before(:each) do
      post '/api/v1/users', params: { 'email': "whatever@example.com",
                                      "password": "password",
                                      "password_confirmation": "password"}
      @status_code = response.status
      @response = JSON.parse(response.body)
      @new_user = User.last
    end

    it 'a user is created in the database' do
      expect(@new_user.email).to eq("whatever@example.com")
    end

    it 'I receive a status code 201' do
      expect(@status_code).to eq(201)
    end

    it 'and I receive a JSON:API response containing a unique api_key for that user' do
      expect(@response).to include(
        'data' => {
          'id' => @new_user.id.to_s,
          'type' => 'user',
          'attributes' => {
            'api_key' => @new_user.api_key
          }
        }
      )
      expect(@new_user.api_key).to match(/[A-Za-z0-9]{24}/)
    end
  end

  describe 'when I send a post request to the users endpoint with invalid email, password, or password confirmation' do
    it 'I receive an appropriate 400-level status code' do
      post '/api/v1/users', params: { 'email': "whatever@example.com",
                                      "password": "password",
                                      "password_confirmation": "bad_password"}
      status_code_1 = response.status
      response_1 = JSON.parse(response.body)

      expect(status_code_1).to eq(400)
      expect(response_1).to include(
        'errors' => [
          "status" => "400",
          "source" => { "pointer" => "/api/v1/users", "parameter" => "password_confirmation" },
          "title" =>  "Invalid Request",
          "detail" => "Password confirmation doesn't match Password."
        ]
      )
    end
  end
end
