class ConnectionSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :professional_id, :client_id, :classification
end
