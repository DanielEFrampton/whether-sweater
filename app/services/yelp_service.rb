class YelpService
  def restaurant_open_at(lat, long, food_type, timestamp)
    response = get_restaurant_data(lat, long, food_type, timestamp)
    JSON.parse(response.body)
  end

  private

  def get_restaurant_data(lat, long, food_type, timestamp)
    Faraday.get('https://api.yelp.com/v3/businesses/search') do |request|
      request.params['term'] = food_type
      request.params['latitude'] = lat
      request.params['longitude'] = long
      request.params['limit'] = 1
      request.params['open_at'] = timestamp

      request.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
    end
  end
end
