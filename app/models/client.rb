class Client < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :subscriptions, -> { where classification: 'subscription' }, class_name: 'Connection', dependent: :destroy
  has_many :subscribed_to, through: :subscriptions, source: :professional
  has_many :professional_list, -> { where classification: 'client_list' }, class_name: 'Connection', dependent: :destroy
  has_many :my_professionals, through: :professional_list, source: :professional

  # TODO: To be used for tracking user no shows and potential blacklist
  def event_no_show
    bookings.where(client_showed_up: false).length
  end

  # TODO: For refactoring in user level
  def event_bookings(status)
    @events = []
    @status = status

    subscribed_to.each do |professional|
      @professional = professional

      next if professional.calendly_token.nil?

      params = set_parameters(professional)
      handle_event(params)
    end
    @events
  end

  private

  def set_parameters(professional)
    parameters = { user: professional.calendly_token.user_uri,
                   invitee_email: user.email,
                   count: 30 }

    case @status
    when 'active'
      parameters[:status] = 'active'
      parameters[:min_start_time] = Time.now
    when 'pending', 'finished'
      parameters[:status] = 'active'
      parameters[:max_start_time] = Time.now
    when 'canceled'
      parameters[:status] = 'canceled'
    end

    parameters
  end

  def handle_event(params)
    response = Calendly::Client.events(@professional.calendly_token.authorization, params: params)
    events_list = response[:data]['collection']

    return if events_list.empty?

    events_list.each do |event|
      event_exists = event_exists?(event)

      next if @status == 'pending' && event_exists.present?
      next if @status == 'finished' && event_exists.nil?

      @events << event_data(event)
    end
  end

  def event_data(event)
    response = Calendly::Client.event_invitee(@professional.calendly_token.authorization, event_uuid(event))
    event['invitee_uri'] = response['uri']
    event['invitee_email'] = response['email']
    event['professional_name'] = @professional.full_name

    {
      id: event_uuid(event),
      type: "#{@status}_events",
      attributes: event.except('created_at', 'event_guests', 'event_memberships', 'updated_at')
    }
  end

  def event_exists?(event)
    Booking.find_by(event_uuid: event_uuid(event))
  end

  def event_uuid(event)
    event['uri'].split('events/').last
  end
end
