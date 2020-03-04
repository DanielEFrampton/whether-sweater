class DailyForecast
  attr_reader :time, :icon, :temperature_high, :temperature_low, :humidity,
              :weekday

  def initialize(time:, icon:, temperature_high:, temperature_low:, humidity:)
    @time = time
    @icon = icon
    @temperature_high = temperature_high
    @temperature_low = temperature_low
    @humidity = humidity
    @weekday = calculate_weekday
  end

  private
  
  def calculate_weekday
    Time.at(@time).to_datetime.strftime('%A')
  end
end
