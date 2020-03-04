class DarkSkyService
  def forecast(lat, long)
    get_forecast("#{lat},#{long}")
  end

  def future_forecast(lat, long, time)
    data = get_forecast("#{lat},#{long}#{',' + time.to_s}")
    FutureForecastResults.new(temperature: data['currently']['temperature'],
                              summary: data['currently']['summary'])
  end

  private

  def get_forecast(params)
    response = connection.get("forecast/#{ENV['DARK_SKY_SECRET']}/#{params}")
    JSON.parse(response.body)
  end

  def connection
    Faraday.new('https://api.darksky.net') do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end
end
