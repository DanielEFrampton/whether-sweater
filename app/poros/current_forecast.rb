class CurrentForecast
  attr_reader :time, :timezone_offset, :summary

  def initialize(current_data:, today_data:, offset:, timezone:)
    @feels_like = current_data[:apparentTemperature]
    @humidity = current_data[:humidity]
    @icon = current_data[:icon]
    @summary = current_data[:summary]
    @temperature = current_data[:temperature]
    @time = current_data[:time]
    @uv_index = current_data[:uvIndex]
    @visibility = current_data[:visibility]
    @day_temperature_high = today_data[:temperatureHigh]
    @day_temperature_low = today_data[:temperatureLow]
    @today_summary = today_data[:summary]
    @timezone_offset = offset
    @timezone = timezone
    @uv_exposure_category = uv_exposure_category
  end

  def uv_exposure_category
    return 'low' if [0, 1, 2].include?(@uv_index)
    return 'moderate' if [3, 4, 5].include?(@uv_index)
    return 'high' if [6, 7].include?(@uv_index)
    return 'very high' if [8, 9, 10].include?(@uv_index)
    return 'extreme' if @uv_index > 10
  end
end
