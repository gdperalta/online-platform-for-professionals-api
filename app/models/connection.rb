class Connection < ApplicationRecord
  belongs_to :professional
  belongs_to :client
end