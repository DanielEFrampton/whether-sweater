class Forecast
  attr_reader :id

  def initialize(weather_info, location_info)
    @id = nil
    @weather_info = weather_info
    @location_info = location_info
  end

  def city
    @location_info[:city]
  end

  def state
    @location_info[:state]
  end

  def country
    @location_info[:country]
  end

  def time
    @weather_info['currently']['time']
  end

  def timezone_offset
    @weather_info['offset']
  end

  def timezone
    @weather_info['timezone']
  end

  def temperature
    @weather_info['currently']['temperature']
  end

  def feels_like
    @weather_info['currently']['apparentTemperature']
  end

  def day_temperature_high
    @weather_info['daily']['data'][0]['temperatureHigh']
  end

  def day_temperature_low
    @weather_info['daily']['data'][0]['temperatureLow']
  end

  def summary
    @weather_info['currently']['summary']
  end

  def icon
    @weather_info['currently']['icon']
  end

  def humidity
    @weather_info['currently']['humidity']
  end

  def uv_index
    @weather_info['currently']['uvIndex']
  end

  def uv_exposure_category
    return 'low' if [0, 1, 2].include?(uv_index)
    return 'moderate' if [3, 4, 5].include?(uv_index)
    return 'high' if [6, 7].include?(uv_index)
    return 'very high' if [8, 9, 10].include?(uv_index)
    return 'extreme' if uv_index > 10
  end

  def visibility
    @weather_info['currently']['visibility']
  end

  def today_summary
    @weather_info['daily']['data'][0]['summary']
  end

  def tonight_summary
    if unix_to_datetime(time).hour < 21
      @weather_info['hourly']['data'].find do |hour_info|
        unix_to_datetime(hour_info['time']).hour == 21
      end['summary']
    else
      summary
    end
  end

  def hourly_forecasts
    @weather_info['hourly']['data'].map do |h|
      h.slice('time', 'icon', 'temperature')
    end.slice(1, 8)
  end

  def daily_forecasts
    @weather_info['daily']['data'].map do |d|
      d.slice!('time', 'icon', 'temperatureHigh', 'temperatureLow', 'humidity')
      d.merge('weekday' => unix_to_datetime(d['time']).strftime('%A'))
    end.slice(1, 5)
  end

  private

  def unix_to_datetime(unix_timestamp)
    Time.at(unix_timestamp).utc.to_datetime.new_offset("#{timezone_offset}:00")
  end
end
