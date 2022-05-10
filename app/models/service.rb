class Service < ApplicationRecord
  belongs_to :professional
  validates :title, presence: true
  validates :details, presence: true
  validates :min_price, numericality: { greater_than_or_equal_to: 0 }
  validates :max_price, numericality: { greater_than: :min_price }
end
