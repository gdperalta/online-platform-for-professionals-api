class Client < ApplicationRecord
  include BookingList

  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :subscriptions, -> { where classification: 'subscription' }, class_name: 'Connection', dependent: :destroy
  has_many :subscribed_to, through: :subscriptions, source: :professional
  has_many :professional_list, -> { where classification: 'client_list' }, class_name: 'Connection', dependent: :destroy
  has_many :my_professionals, through: :professional_list, source: :professional

  # TODO: To be used for tracking user no shows and potential blacklist
  def event_no_show
    bookings.where(client_showed_up: false).length
  end
end
