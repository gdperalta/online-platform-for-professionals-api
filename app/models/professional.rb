class Professional < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :work_portfolios, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :subscriptions, -> { where classification: 'subscription' }, class_name: 'Connection', dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :client
  has_many :client_list, -> { where classification: 'client_list' }, class_name: 'Connection', dependent: :destroy
  has_many :clientele, through: :client_list, source: :client
  has_one :calendly_token, dependent: :destroy
  validates :user_id, uniqueness: true
  validates :license_number, presence: true, uniqueness: true, length: { is: 7 }

  def average_rating
    reviews.average(:rating)
  end

  # TODO: For refactoring in user level
  def event_bookings(status)
    @events = []

    return events if calendly_token.nil?

    @status = status

    subscribers.each do |subscriber|
      params = set_parameters(subscriber)
      handle_event(params)
    end
    @events
  end

  private

  def set_parameters(client)
    parameters = { user: calendly_token.user_uri,
                   invitee_email: client.user.email,
                   count: 30 }

    case @status
    when 'active'
      parameters[:status] = 'active'
      parameters[:min_start_time] = Time.now
    when 'finished'
      parameters[:status] = 'active'
      parameters[:max_start_time] = Time.now
    when 'canceled'
      parameters[:status] = 'canceled'
    end

    parameters
  end

  def handle_event(params)
    response = Calendly::Client.events(calendly_token.authorization, params: params)
    events_list = response[:data]['collection']

    return if events_list.empty?

    events_list.each do |event|
      @events << event_data(event)
    end
  end

  def event_data(event)
    event_uuid = event['uri'].split('events/').last
    response = Calendly::Client.event_invitee(calendly_token.authorization, event_uuid)
    event['invitee_uri'] = response['uri']
    event['invitee_email'] = response['email']

    {
      id: event_uuid,
      type: "#{@status}_events",
      attributes: event.except('created_at', 'event_guests', 'event_memberships', 'updated_at')
    }
  end
end
