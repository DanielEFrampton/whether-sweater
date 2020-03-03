class DarkSkyService
  def forecast(lat, long)
    get_forecast("#{lat},#{long}")
  end

  def simple_future_forecast(lat, long, time)
    data = get_forecast("#{lat},#{long}#{',' + time.to_s}")
    FutureForecastResults.new(temperature: data['currently']['temperature'],
                              summary: data['currently']['summary'])
  end

  private

    def get_forecast(query_params)
      response = Faraday.get("https://api.darksky.net/forecast/#{ENV['DARK_SKY_SECRET']}/#{query_params}")
      JSON.parse(response.body)
    end
end
