FactoryBot.define do
  factory :review do
    # id { 1 }
    client_id { 2 }
    rating { 3 }
    body { 'My review' }
  end
end
