module Calendly
  class Client
    def self.user(authorization)
      Request.call(http_method: 'get',
                   endpoint: '/users/me',
                   authorization: authorization)
    end

    def self.events(authorization, params: {})
      Request.call(http_method: 'get',
                   endpoint: '/scheduled_events',
                   authorization: authorization,
                   params: params)
    end

    def self.event_invitee(authorization, event_uuid)
      response = Request.call(http_method: 'get',
                              endpoint: "/scheduled_events/#{event_uuid}/invitees",
                              authorization: authorization)
      response[:data]['collection'].first
    end

    # def self.cancel_event(authorization, event_uuid, cancellation_reason)
    #   Request.call(http_method: 'post',
    #                endpoint: "/scheduled_events/#{event_uuid}/cancellation",
    #                authorization: authorization,
    #                payload: { "reason": cancellation_reason }.to_json)
    # end

    def self.create_invitee_no_show(authorization, invitee_link)
      Request.call(http_method: 'post',
                   endpoint: '/invitee_no_shows',
                   authorization: authorization,
                   payload: { "invitee": invitee_link }.to_json)
    end

    def self.delete_invitee_no_show(authorization, no_show_link)
      Request.call(http_method: 'delete',
                   endpoint: "/invitee_no_shows/#{no_show_link}",
                   authorization: authorization)
    end
  end
end
