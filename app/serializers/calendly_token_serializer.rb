class CalendlyTokenSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :authorization, :user_uri, :organization_uri, :scheduling_url
  belongs_to :professional
end
