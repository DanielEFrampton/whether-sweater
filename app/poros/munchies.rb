class Munchies
  attr_reader :id, :forecast, :travel_time, :restaurant, :end_location

  def initialize(forecast, restaurant_info, travel_time, end_location)
    @id = nil
    @end_location = end_location
    @travel_time = travel_time
    @forecast = forecast
    @restaurant = restaurant_info
  end
end
