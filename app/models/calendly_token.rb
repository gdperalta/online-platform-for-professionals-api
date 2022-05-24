class CalendlyToken < ApplicationRecord
  belongs_to :professional
  before_validation :add_tokens
  validates :professional_id, uniqueness: true
  validates :authorization, presence: true # , uniqueness: true

  def add_tokens
    return if authorization.blank?

    response = Calendly::Client.user(authorization)

    if response[:code] < 300
      self.user_uri = response[:data]['resource']['uri']
      self.organization_uri = response[:data]['resource']['current_organization']
      self.scheduling_url = response[:data]['resource']['scheduling_url']
    else
      errors.add(:authorization, 'unauthorized! Please check calendly token.')
    end
  end
end
