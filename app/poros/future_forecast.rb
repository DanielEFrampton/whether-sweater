class FutureForecast
  attr_reader :summary, :temperature
  
  def initialize(summary, temperature)
    @summary = summary
    @temperature = temperature
  end
end
