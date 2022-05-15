FactoryBot.define do
  factory :review do
    professional_id { 1 }
    rating { 3 }
    body { 'My review' }
  end
end
