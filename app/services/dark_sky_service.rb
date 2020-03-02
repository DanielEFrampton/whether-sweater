class DarkSkyService
  def forecast(lat, long, time = nil)
    get_forecast("#{lat},#{long}#{',' + time.to_s if time}")
  end

  private

    def get_forecast(query_params)
      response = Faraday.get("https://api.darksky.net/forecast/#{ENV['DARK_SKY_SECRET']}/#{query_params}")
      JSON.parse(response.body)
    end
end
