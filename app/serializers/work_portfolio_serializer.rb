class WorkPortfolioSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :title, :details
  belongs_to :professional
end
