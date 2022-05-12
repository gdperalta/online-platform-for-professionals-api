class CalendlyTokenSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :authorization, :user, :organization
end