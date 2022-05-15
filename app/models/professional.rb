class Professional < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :work_portfolios, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :subscriptions, -> { where classification: 'subscription' }, class_name: 'Connection', dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :client
  has_many :client_list, -> { where classification: 'client_list' }, class_name: 'Connection', dependent: :destroy
  has_many :clients, through: :client_list
  has_one :calendly_token, dependent: :destroy
  validates :license_number, presence: true, uniqueness: true, length: { is: 7 }

  def event_bookings
    events = []
    subscribers.each do |subscriber|
      events << events_list({ user: calendly_token.user,
                              invitee_email: subscriber.user.email,
                              min_start_time: Time.now,
                              count: 5 })
    end
    events
  end

  private

  def events_list(params)
    response = Calendly::Client.events(calendly_token.authorization, params: params)

    result = event_data(response)

    response[:data]['collection'].each do |event|
      result[:data] << handle_event_data(event)
    end

    result
  end

  def event_data(response)
    {
      links: {
        next: response[:data]['pagination']['next_page_token'],
        previous: response[:data]['pagination']['previous_page_token']
      },
      data: []
    }
  end

  def handle_event_data(event)
    event_uuid = event['uri'].split('events/').last
    event['invitee_uri'] = Calendly::Client.event_invitee(calendly_token.authorization, event_uuid)

    {
      type: 'events',
      id: event_uuid,
      attributes: event.except('created_at', 'event_guests', 'event_memberships', 'updated_at')
    }
  end
end
