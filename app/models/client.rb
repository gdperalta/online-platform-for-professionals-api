class Client < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :subscriptions, -> { where classification: 'subscription' }, class_name: 'Connection', dependent: :destroy
  has_many :subscribed_to, through: :subscriptions, source: :professional
  has_many :professional_list, -> { where classification: 'client_list' }, class_name: 'Connection', dependent: :destroy
  has_many :my_professionals, through: :professional_list, source: :professional

  # TODO: For refactoring
  def event_bookings(status)
    events = []
    @status = status
    subscribed_to.each do |professional|
      @professional = professional

      next if professional.calendly_token.nil?

      params = set_parameters(professional)
      events << handle_event(params)
    end
    events
  end

  private

  def set_parameters(professional)
    parameters = { user: professional.calendly_token.user_uri,
                   invitee_email: user.email,
                   count: 5 }

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
    response = Calendly::Client.events(@professional.calendly_token.authorization, params: params)

    result = format_response(response)

    response[:data]['collection'].each do |event|
      result[:data] << event_data(event)
    end

    result
  end

  def format_response(response)
    {
      links: {
        next: response[:data]['pagination']['next_page_token'],
        previous: response[:data]['pagination']['previous_page_token']
      },
      data: []
    }
  end

  def event_data(event)
    event_uuid = event['uri'].split('events/').last
    response = Calendly::Client.event_invitee(@professional.calendly_token.authorization, event_uuid)
    event['invitee_uri'] = response['uri']
    event['invitee_email'] = response['email']

    {
      id: event_uuid,
      type: "#{@status}_events",
      attributes: event.except('created_at', 'event_guests', 'event_memberships', 'updated_at')
    }
  end
end
