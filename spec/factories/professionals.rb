FactoryBot.define do
  factory :professional do
    id { 1 }
    field { 'Electronics Engineer' }
    license_number { '0012345' }
    office_address { 'Office Address' }
    headline { 'MyHeadline' }
    association :user, :professional

    trait :with_services do
      before(:create) do |professional|
        professional.services.build(attributes_for(:service))
      end
    end

    trait :with_work_portfolios do
      before(:create) do |professional|
        professional.work_portfolios.build(attributes_for(:work_portfolio))
      end
    end

    trait :with_calendly_token do
      before(:create) do |professional|
        professional.build_calendly_token(authorization: 'authorization-token')
      end
    end
  end
end
