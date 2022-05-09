FactoryBot.define do
  factory :professional do
    id { 1 }
    field { 'Electrical Engineer' }
    license_number { '0012345' }
    office_address { 'Office Address' }
    headline { 'MyHeadline' }
    association :user, :professional

    trait :with_reviews do
      before(:create) do |professional|
        professional.reviews.build(attributes_for(:review))
      end
    end

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
  end
end
