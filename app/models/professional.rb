class Professional < ApplicationRecord
  include BookingList
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :work_portfolios, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :subscriptions, -> { where classification: 'subscription' }, class_name: 'Connection', dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :client
  has_many :client_list, -> { where classification: 'client_list' }, class_name: 'Connection', dependent: :destroy
  has_many :clientele, through: :client_list, source: :client
  has_one :calendly_token, dependent: :destroy
  validates :user_id, uniqueness: true
  validates :license_number, presence: true, uniqueness: true, length: { is: 7 }
  validates :field, presence: true, inclusion: { in: Field.pluck(:name), message: '%<value>s is not a valid field' }

  def full_name
    "#{user.first_name} #{user.last_name}"
  end

  def average_rating
    reviews.average(:rating) || 0
  end
end
