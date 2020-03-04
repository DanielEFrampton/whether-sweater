class Munchies
  attr_reader :id, :forecast, :travel_time, :restaurant, :end_location

  # def initialize(forecast, restaurant_info, travel_time, end_location)
  def initialize(params)
    @id = nil

    @start = params[:start]
    @end = params[:end]
    @food = params[:food]

    @end_location = end_location_info[:city_state]
    @travel_time = distance_info[:travel_time]
    @forecast = generate_forecast.summary
    @restaurant = generate_restaurant
  end

  private

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

  def generate_restaurant
    YelpService.new.restaurant_open_at(end_location_info[:lat],
                                       end_location_info[:long],
                                       @food,
                                       distance_info[:arrival_time])
  end
end
