class Service < ApplicationRecord
  belongs_to :professional
  validates :title, presence: true
  validates :details, presence: true
  validates :min_price, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validates :max_price, numericality: { greater_than: :min_price }, allow_blank: true
end
