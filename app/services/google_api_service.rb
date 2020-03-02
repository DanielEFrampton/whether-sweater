class GoogleApiService
  def geocode(location)
    get_geocode(location)
  end

  def distance(start_location, end_location)
    get_distance(start_location, end_location)
  end

  private

  def get_geocode(location)
    response = connection.get('geocode/json?address=denver,co')
    JSON.parse(response.body)
  end

  def get_distance(start_location, end_location)
    response = connection.get("distancematrix/json?units=imperial&origins=#{start_location}&destinations=#{end_location}")
    JSON.parse(response.body)
  end

  def connection
    Faraday.new('https://maps.googleapis.com/maps/api') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params['key'] = ENV['GOOGLE_API_KEY']
    end
  end
end
