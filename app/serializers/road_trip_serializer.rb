class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :travel_time, :forecast, :origin, :destination
end
