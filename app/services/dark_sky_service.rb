class DarkSkyService
  def forecast(lat, long)
    get_forecast("#{lat},#{long}")
  end

  private

    def get_forecast(lat_long)
      response = Faraday.get("https://api.darksky.net/forecast/#{ENV['DARK_SKY_SECRET']}/#{lat_long}")
      JSON.parse(response.body)
    end
end
