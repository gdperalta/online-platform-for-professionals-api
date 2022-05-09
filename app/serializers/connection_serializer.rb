class ConnectionSerializer
  include JSONAPI::Serializer
  attributes :professional_id, :client_id
end
