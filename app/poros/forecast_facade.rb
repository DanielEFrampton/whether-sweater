class ForecastFacade
  attr_reader :hourly_forecasts, :daily_forecasts, :current_forecast, :location,
              :tonight_summary, :id

  def initialize(weather:, geocode:)
    @id = nil
    @hourly_forecasts = make_hourly_forecasts(weather['hourly']['data'][1..8])
    @daily_forecasts = make_daily_forecasts(weather['daily']['data'][1..5])
    @current_forecast = make_current_forecast(weather)
    @location = geocode
    @tonight_summary = find_tonight_summary(weather)
  end

  def find_tonight_summary(weather)
    if unix_to_datetime(@current_forecast.time).hour < 21
      weather['hourly']['data'].find do |hourly_forecast|
        unix_to_datetime(hourly_forecast['time']).hour == 21
      end['summary']
    else
      @current_forecast.summary
    end
  end

  private

  def make_current_forecast(data)
    current_options = {current_data: data['currently'].symbolize_keys,
                       today_data: data['daily']['data'][0].symbolize_keys,
                       offset: data['offset'],
                       timezone: data['timezone']}
    CurrentForecast.new(current_options)
  end

  def make_hourly_forecasts(hours)
    hours.map do |info|
      hour_options = info.slice('time', 'icon', 'temperature', 'summary')
      hour_options = hour_options.symbolize_keys
      HourlyForecast.new(hour_options)
    end
  end

  def make_daily_forecasts(days)
    days.map do |d|
      opt = d.slice('time','icon','temperatureHigh','temperatureLow','humidity')
      opt = opt.transform_keys { |key| key.underscore }
      opt = opt.symbolize_keys
      DailyForecast.new(opt)
    end
  end

  def unix_to_datetime(unix_timestamp)
    date_time = Time.at(unix_timestamp).utc.to_datetime
    date_time.new_offset("#{@current_forecast.timezone_offset}:00")
  end
end
