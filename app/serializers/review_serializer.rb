class ReviewSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :rating, :body
  has_one :professional
  has_one :client
end
