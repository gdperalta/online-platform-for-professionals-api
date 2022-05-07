class UserSerializer
  include JSONAPI::Serializer
  attributes :email, :first_name, :last_name, :contact_number, :city, :region, :role
end
