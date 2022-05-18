class CalendlyTokenSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :authorization, :user_uri, :organization_uri
  belongs_to :professional
end
