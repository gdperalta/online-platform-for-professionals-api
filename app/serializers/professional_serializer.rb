class ProfessionalSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :field, :license_number, :office_address, :headline
  belongs_to :user
  has_many :work_portfolios
  has_many :services
  has_many :reviews
end
