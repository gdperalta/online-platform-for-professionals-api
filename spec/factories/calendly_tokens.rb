FactoryBot.define do
  factory :calendly_token do
    professional_id { 1 }
    authorization { 'authorization-token' }
    # user { 'user_uri' }
    # organization { 'org_uri' }
  end
end
