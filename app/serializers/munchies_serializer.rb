require 'fast_jsonapi'

class MunchiesSerializer
  include FastJsonapi::ObjectSerializer
  set_id nil
  set_type :munchie
  attributes :destination_city,
             :travel_time,
             :forecast,
             :restaurant,
             :id
end
