class DailySerializer
  include FastJsonapi::ObjectSerializer
  set_id nil
  set_type :daily_forecast
  attributes :daily_date,
              :daily_sunrise,
              :daily_sunset,
              :daily_max_temp,
              :daily_min_temp,
              :daily_conditions,
              :daily_icon,
              :id
end
