class GoogleApiService
  def geocode(location)
    get_geocode(location)
  end

  def get_geocode(location)
    response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json?address=denver,co') do |request|
      request.params['key'] = ENV['GOOGLE_API_KEY']
    end
    JSON.parse(response.body)
  end
end
