class ServiceSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :professional_id, :title, :details, :min_price, :max_price
end
