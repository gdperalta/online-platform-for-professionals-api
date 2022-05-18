class Client < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy

  has_many :subscriptions, -> { where classification: 'subscription' }, class_name: 'Connection', dependent: :destroy
  has_many :subscribed_to, through: :subscriptions, source: :professional
  has_many :professional_list, -> { where classification: 'client_list' }, class_name: 'Connection', dependent: :destroy
  has_many :my_professionals, through: :professional_list, source: :professional
end
