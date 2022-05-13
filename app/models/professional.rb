class Professional < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :connections, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :work_portfolios, dependent: :destroy
  has_many :clients, through: :connections
  has_one :calendly_token, dependent: :destroy

  validates :license_number, presence: true, uniqueness: true, length: { is: 7 }
end
