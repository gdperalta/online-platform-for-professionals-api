class WorkPortfolioSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :professional_id, :title, :details
end
