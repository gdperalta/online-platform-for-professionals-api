module Calendly
  class Client
    attr_reader :organization_uri, :user_uri

    def initialize(response)
      @response = response
      @organization_uri = response[:data]['resource']['current_organization']
      @user_uri = response[:data]['resource']['uri']
    end

    def self.user(authorization)
      response = Request.call(http_method: 'get',
                              endpoint: '/users/me',
                              authorization: authorization)
      new(response)
    end

    def self.events(authorization, params: {})
      Request.call(http_method: 'get',
                   endpoint: '/scheduled_events',
                   authorization: authorization,
                   params: params)
    end

    def self.event_invitee(authorization, event_id)
      response = Request.call(http_method: 'get',
                              endpoint: "/scheduled_events/#{event_id}/invitees",
                              authorization: authorization)
      response[:data]['collection'].first['uri']
    end
  end
end
