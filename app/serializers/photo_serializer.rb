require 'fast_jsonapi'

class PhotoSerializer
  include FastJsonapi::ObjectSerializer
  set_id nil
  set_type :image
  attributes :image
             :id
end
