class Client < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :connections, dependent: :destroy
  has_many :professionals, through: :connections
end
