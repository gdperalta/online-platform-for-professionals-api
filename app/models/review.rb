class Review < ApplicationRecord
  belongs_to :professional
  belongs_to :client
  validates :rating, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 5
  }
  validates :body, presence: true
  validate :confirmed_booking?

  def confirmed_booking?
    confirmed_booking = Booking.find_by(professional_id: professional_id, client_id: client_id,
                                        client_showed_up: true)

    errors.add(:client_id, 'must have a confirmed, finished meeting with the professional') if confirmed_booking.nil?
  end
end
