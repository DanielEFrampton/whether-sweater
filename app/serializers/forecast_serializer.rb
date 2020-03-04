class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :location,
             :current_forecast,
             :tonight_summary,
             :hourly_forecasts,
             :daily_forecasts
end
