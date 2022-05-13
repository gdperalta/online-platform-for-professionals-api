FactoryBot.define do
  factory :service do
    professional_id { 1 }
    title { 'My Service' }
    details { 'Service Details' }
    min_price { 50 }
    max_price { 100 }
  end
end
