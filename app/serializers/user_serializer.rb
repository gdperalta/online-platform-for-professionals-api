class UserSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :email, :first_name, :last_name, :contact_number, :city, :region, :role
end
