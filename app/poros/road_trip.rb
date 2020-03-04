class RoadTrip
  attr_reader :id, :forecast, :travel_time, :origin, :destination

  # def initialize(forecast:, travel_time:, origin:, destination:)
  def initialize(params)
    @id = nil

    @start = params[:origin]
    @end = params[:destination]

    @forecast = generate_forecast
    @travel_time = distance_info[:travel_time]
    @origin = city_state(@start)
    @destination = city_state(@end)
  end

  private

  def city_state(string)
    string.gsub(',', ', ')
  end

  def end_location_info
    @end_location_info ||= GoogleApiService.new.geocode(@end)
  end

  def distance_info
    @distance_info ||= GoogleApiService.new.distance(@start, @end)
  end

  def generate_forecast
    DarkSkyService.new.future_forecast(end_location_info[:lat],
                                       end_location_info[:long],
                                       distance_info[:arrival_time])
  end
end
