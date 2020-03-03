class UnsplashService
  def background(location)
    image_url = get_background_url(location)
    Background.new(image_url)
  end

  private

  def get_background_url(location)
    city = location.gsub(',', ', ')
    response = Faraday.get('https://api.unsplash.com/search/photos') do |request|
      request.headers['Authorization'] = "Client-ID #{ENV['UNSPLASH_ACCESS_KEY']}"
      request.headers['Accept-Version'] = "v1"
      request.params['orientation'] = 'landscape'
      request.params['query'] = city
      request.params['page'] = 1
      request.params['per_page'] = 1
    end
    JSON.parse(response.body)['results'][0]['urls']['raw']
  end
end
