class ProfessionalSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :field, :license_number, :office_address, :headline
end
