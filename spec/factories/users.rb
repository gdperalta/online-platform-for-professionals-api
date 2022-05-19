FactoryBot.define do
  factory :user do
    password { 'password' }
    first_name { 'John' }
    last_name { 'Cruz' }
    city { 'Manila' }
    region { 'NCR' }
    confirmed_at { Time.now }

    trait :professional do
      id { 1 }
      contact_number { '9151234567' }
      email { 'pro@email.com' }
      role { 'professional' }
    end

    trait :client do
      id { 2 }
      contact_number { '9151239876' }
      email { 'client@email.com' }
      role { 'client' }

      # after(:create) do |user|
      #   connection = Connection.new(
      #     professional_id: 1,
      #     client_id: user.client.id,
      #     classification: 'subscription'
      #   )
      #   connection.save
      # end
    end

    trait :no_association do
      id { 3 }
      contact_number { '9158765432' }
      email { 'test@email.com' }
      role { 'professional' }
    end

    trait :admin do
      id { 4 }
      contact_number { '9134652874' }
      email { 'admin@email.com' }
      role { 'admin' }
    end
  end
end
