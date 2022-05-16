FactoryBot.define do
  factory :booking do
    professional { nil }
    client { nil }
    client_attended { false }
    status { "MyString" }
    event_uuid { "MyString" }
  end
end
