class ReviewSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :professional_id, :client_id, :rating, :body
end
