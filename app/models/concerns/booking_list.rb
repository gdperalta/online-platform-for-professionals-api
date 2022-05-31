module BookingList
  extend ActiveSupport::Concern

  included do
    def user_calendly_token(resource: '')
      user.professional? ? calendly_token : resource.calendly_token
    end

    def invitee_email(resource)
      resource.user.client? ? resource.user.email : user.email
    end

    def connections
      user.professional? ? subscribers : subscribed_to
    end
  end

  def event_bookings(status)
    @events = []
    @status = status

    return events if user.professional? && user_calendly_token.nil?

    connections.each do |connection|
      next if user_calendly_token(resource: connection).nil?

      @resource = connection
      params = set_parameters
      handle_event(params)
    end
    @events
  end

  private

  def set_parameters
    parameters = { user: user_calendly_token(resource: @resource).user_uri,
                   invitee_email: invitee_email(@resource),
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
    response = Calendly::Client.events(user_calendly_token(resource: @resource).authorization, params: params)
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
    response = Calendly::Client.event_invitee(user_calendly_token(resource: @resource).authorization, event_uuid(event))
    assign_data(event, response)

    {
      id: event_uuid(event),
      type: @status.blank? ? 'events' : "#{@status}_events",
      attributes: event.except('created_at', 'event_guests', 'event_memberships', 'updated_at')
    }
  end

  def assign_data(event, response)
    event['invitee_uri'] = response['uri']
    event['invitee_email'] = response['email']
    if user.professional?
      event['invitee_name'] = response['name']
    elsif user.client?
      event['professional_name'] = @resource.full_name
    end
  end

  def event_exists?(event)
    Booking.find_by(event_uuid: event_uuid(event))
  end

  def event_uuid(event)
    event['uri'].split('events/').last
  end
end
