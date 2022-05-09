class Client < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :connections
  has_many :professionals, through: :connections
end
