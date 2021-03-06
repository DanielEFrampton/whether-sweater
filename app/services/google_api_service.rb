class GoogleApiService
  def geocode(location)
    data = get_geocode(location)
    format_geocode_data(data)
  end

  def distance(start_location, end_location)
    data = get_distance(start_location, end_location)
    format_distance_data(data)
  end

  private

  def get_geocode(location)
    response = connection.get("geocode/json?address=#{location}")
    JSON.parse(response.body)
  end

  def get_distance(start_location, end_location)
    response = connection.get('distancematrix/json') do |request|
      request.params['units'] = 'imperial'
      request.params['origins'] = start_location
      request.params['destinations'] = end_location
    end
    JSON.parse(response.body)
  end

  def connection
    Faraday.new('https://maps.googleapis.com/maps/api') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params['key'] = ENV['GOOGLE_API_KEY']
    end
  end

  def format_geocode_data(data)
    {
      city: city = data['results'][0]['address_components'][0]['long_name'],
      state: state = data['results'][0]['address_components'][2]['short_name'],
      country: data['results'][0]['address_components'][3]['long_name'],
      city_state: city + ', ' + state,
      lat: data['results'][0]['geometry']['location']['lat'],
      long: data['results'][0]['geometry']['location']['lng']
    }
  end

  def format_distance_data(data)
    duration = data['rows'][0]['elements'][0]['duration']
    {
      travel_time: duration['text'],
      arrival_time: arrival_time(duration['value'])
    }
  end

  def arrival_time(seconds)
    Time.now.to_i + seconds
  end
end
