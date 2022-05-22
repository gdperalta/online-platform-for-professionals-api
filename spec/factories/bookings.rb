FactoryBot.define do
  factory :booking do
    client_showed_up { true }
    finished { true }
    event_uuid { 'MyString' }
    start_time { '2022-01-1 10:49:44.719404456 +0800' }
    end_time { '2022-01-1 11:49:44.719404456 +0800' }
    invitee_link { 'Invitee_link' }
  end
end
