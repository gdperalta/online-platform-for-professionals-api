class ClientSerializer
  include JSONAPI::Serializer
  attributes :user_id
  belongs_to :user
  has_many :reviews
end
