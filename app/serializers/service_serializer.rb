class ServiceSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :title, :details, :min_price, :max_price
  belongs_to :professional
end
