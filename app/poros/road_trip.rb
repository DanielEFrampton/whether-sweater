class RoadTrip
  attr_reader :id, :forecast, :travel_time, :origin, :destination

  def initialize(forecast:, travel_time:, origin:, destination:)
    @id = nil
    @forecast = forecast
    @travel_time = travel_time
    @origin = origin
    @destination = destination
  end
end
