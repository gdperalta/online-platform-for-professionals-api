class WorkPortfolio < ApplicationRecord
  belongs_to :professional
  validates :title, presence: true
  validates :details, presence: true
end
