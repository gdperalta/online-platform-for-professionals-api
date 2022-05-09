FactoryBot.define do
  factory :user do
    password { 'password' }
    first_name { 'John' }
    last_name { 'Cruz' }
    contact_number { '9151234567' }
    city { 'Manila' }
    region { 'NCR' }
    confirmed_at { Time.now }

    trait :professional do
      id { 1 }
      email { 'pro@email.com' }
      role { 'professional' }
    end

    trait :client do
      id { 2 }
      email { 'client@email.com' }
      role { 'client' }

      after(:create) do |user|
        review = Review.new(attributes_for(:review))
        review.client_id = user.client.id
        review.save
      end
    end

    trait :no_association do
      id { 3 }
      email { 'test@email.com' }
      role { 'professional' }
    end
  end
end
