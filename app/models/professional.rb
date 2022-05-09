class Professional < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :connections
  has_many :clients, through: :connections
end
