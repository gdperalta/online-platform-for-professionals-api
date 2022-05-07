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

      before(:create) do |user|
        user.build_professional(field: 'Electrical Engineer',
                                license_number: '0012345')
      end
    end
  end
end
