class HourlySerializer
  include FastJsonapi::ObjectSerializer
  set_id nil
  set_type :hourly_forecast
  attributes :time,
              :temperature,
              :wind_speed,
              :wind_direction,
              :conditions,
              :icon,
              :id
end
