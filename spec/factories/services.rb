FactoryBot.define do
  factory :service do
    title { 'My Service' }
    details { 'Service Details' }
    min_price { 1 }
    max_price { 10 }
  end
end
