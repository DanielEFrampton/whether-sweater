class DarkSkyService
  def forecast(lat, long)
    get_forecast("#{lat},#{long}")
  end

  private

    def get_forecast(lat_long)
      # build out via TDD via model test
    end
end
