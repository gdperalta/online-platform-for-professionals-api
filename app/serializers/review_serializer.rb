class ReviewSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :rating, :body
  belongs_to :professional
  belongs_to :client
end
