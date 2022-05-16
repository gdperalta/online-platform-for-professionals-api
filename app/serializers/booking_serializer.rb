class BookingSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :event_uuid, :finished, :start_time, :end_time, :client_showed_up, :no_show_link, :invitee_link
  belongs_to :professional
  belongs_to :client
end
