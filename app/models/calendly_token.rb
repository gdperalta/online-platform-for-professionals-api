class CalendlyToken < ApplicationRecord
  belongs_to :professional
  before_create :add_tokens
  validates :authorization, presence: true, uniqueness: true

  def add_tokens
    calendly_api = Calendly::Client.user(authorization)
    self.user = calendly_api.user_uri
    self.organization = calendly_api.organization_uri
  end
end
