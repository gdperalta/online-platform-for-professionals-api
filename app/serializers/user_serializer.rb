class UserSerializer
  include JSONAPI::Serializer
  set_type :personal_details
  set_key_transform :camel_lower
  attributes :email, :first_name, :last_name, :contact_number, :city, :region, :role
  has_one :professional, if: proc { |record| record.professional.present? }
  has_one :client, if: proc { |record| record.client.present? }
end
