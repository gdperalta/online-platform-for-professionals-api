class ProfessionalSerializer
  include JSONAPI::Serializer
  attributes :field, :license_number, :office_address, :headline
end
