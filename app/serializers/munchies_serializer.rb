class MunchiesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :travel_time, :forecast, :end_location, :restaurant
end
