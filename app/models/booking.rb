class Booking < ApplicationRecord
  belongs_to :professional
  belongs_to :client
  validates :client_showed_up, inclusion: { in: [true, false],
                                            message: 'value %<value>s is not valid' }
  validates :event_uuid, presence: true
  validates :invitee_link, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  after_validation :mark_client_no_show
  after_validation :cancel_marked_client_no_show
  validate :verify_date

  def verify_date
    errors.add(:end_time, 'scheduled time is not yet finished') if end_time > Time.now
  end

  def mark_client_no_show
    return unless client_showed_up_changed? && !client_showed_up

    response = Calendly::Client.create_invitee_no_show(professional.calendly_token.authorization, invitee_link)

    if response[:status] == 'Success'
      self.no_show_link = response[:data]['resource']['uri'].split('no_shows/').last
    else
      errors.add(:invitee_link, 'incorrect')
    end
  end

  def cancel_marked_client_no_show
    return unless changed_attributes['client_showed_up'] == false && client_showed_up

    response = Calendly::Client.delete_invitee_no_show(professional.calendly_token.authorization, no_show_link)

    if response[:code] == 204
      self.no_show_link = nil
    else
      errors.add(:no_show_link, 'incorrect')
    end
  end
end
