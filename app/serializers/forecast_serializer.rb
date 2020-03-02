class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :city,
             :state,
             :country,
             :time,
             :timezone_offset,
             :timezone,
             :city,
             :state,
             :country,
             :temperature,
             :feelsLike,
             :day_temperature_high,
             :day_temperature_low,
             :summary,
             :icon,
             :humidity,
             :uv_index,
             :uv_exposure_category,
             :visibility,
             :today_summary,
             :tonight_summary,
             :hourly_forecasts,
             :daily_forecasts
end
