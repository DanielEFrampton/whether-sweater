class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
end
