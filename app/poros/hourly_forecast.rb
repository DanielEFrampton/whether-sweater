class HourlyForecast
  attr_reader :time, :summary

  def initialize(time:, icon:, temperature:, summary:)
    @time = time
    @icon = icon
    @temperature = temperature
    @summary = summary
  end
end
