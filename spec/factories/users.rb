FactoryBot.define do
  factory :user do
    password { 'password' }
    first_name { 'John' }
    last_name { 'Cruz' }
    contact_number { '9151234567' }
    city { 'Manila' }
    region { 'NCR' }

    trait :professional do
      id { 1 }
      email { 'pro@email.com' }
      role { 'professional' }
    end

    trait :client do
      id { 2 }
      email { 'client@email.com' }
      role { 'client' }

      before(:create) do |user|
        user.build_client(id: 2)
      end
    end

    trait :no_association do
      id { 3 }
      email { 'test@email.com' }
      role { 'professional' }
    end
  end
end
