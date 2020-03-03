class Forecast
  attr_reader :id,
              :city,
              :state,
              :country,
              :time,
              :timezone_offset,
              :timezone,
              :temperature,
              :feelsLike,
              :day_temperature_high,
              :day_temperature_low,
              :summary,
              :icon,
              :humidity,
              :uv_index,
              :visibility,
              :today_summary

  def initialize(weather_info, location_info)
    @id = nil

    @city = location_info[:city]
    @state = location_info[:state]
    @country = location_info[:country]

    @time = weather_info['currently']['time']
    @timezone_offset = weather_info['offset']
    @timezone = weather_info['timezone']
    @temperature = weather_info['currently']['temperature']
    @feelsLike = weather_info['currently']['apparentTemperature']
    @day_temperature_high = weather_info['daily']['data'][0]['temperatureHigh']
    @day_temperature_low = weather_info['daily']['data'][0]['temperatureLow']
    @summary = weather_info['currently']['summary']
    @icon = weather_info['currently']['icon']
    @humidity = weather_info['currently']['humidity']
    @uv_index = weather_info['currently']['uvIndex']
    @visibility = weather_info['currently']['visibility']
    @today_summary = weather_info['daily']['data'][0]['summary']
    @hourly_forecasts = weather_info['hourly']['data']
    @daily_forecasts = weather_info['daily']['data'].slice(1, 5)
  end

  def uv_exposure_category
    return 'low' if [0, 1, 2].include?(@uv_index)
    return 'moderate' if [3, 4, 5].include?(@uv_index)
    return 'high' if [6, 7].include?(@uv_index)
    return 'very high' if [8, 9, 10].include?(@uv_index)
    return 'extreme' if @uv_index > 10
  end

  def tonight_summary
    if unix_to_datetime(@time).hour < 21
      @hourly_forecasts.find do |hour_info|
        unix_to_datetime(hour_info['time']).hour == 21
      end['summary']
    else
      @summary
    end
  end

  def hourly_forecasts
    @hourly_forecasts.map do |h|
      h.slice('time', 'icon', 'temperature')
    end.slice(1, 8)
  end

  def daily_forecasts
    @daily_forecasts.map do |d|
      d.slice!('time', 'icon', 'temperatureHigh', 'temperatureLow', 'humidity')
      d.merge('weekday' => unix_to_datetime(d['time']).strftime('%A'))
    end
  end

  private

    def unix_to_datetime(unix_timestamp)
      Time.at(unix_timestamp).utc.to_datetime.new_offset("#{@timezone_offset}:00")
    end
end
