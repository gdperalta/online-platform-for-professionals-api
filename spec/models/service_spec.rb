require 'rails_helper'

RSpec.describe Service, type: :model do
  let!(:professional) { create(:professional) }
  let(:service) { build(:service) }

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(service).to be_valid
    end
    context 'title' do
      it 'is invalid if blank' do
        service.title = ''
        expect(service).to_not be_valid
        expect(service.errors.to_hash.keys).to include(:title)
        expect(service.errors[:title]).to include("can't be blank")
      end
    end

    context 'details' do
      it 'is invalid if blank' do
        service.details = ''
        expect(service).to_not be_valid
        expect(service.errors.to_hash.keys).to include(:details)
        expect(service.errors[:details]).to include("can't be blank")
      end
    end

    context 'min_price' do
      it 'is invalid if it is negative' do
        service.min_price = -10
        expect(service).to_not be_valid
        expect(service.errors.to_hash.keys).to include(:min_price)
        expect(service.errors[:min_price]).to include('must be greater than or equal to 0')
      end
    end

    context 'max_price' do
      it 'is invalid if it is less than min_price' do
        service.max_price = 25
        expect(service).to_not be_valid
        expect(service.errors.to_hash.keys).to include(:max_price)
        expect(service.errors[:max_price]).to include("must be greater than #{service.min_price}")
      end
    end
  end
end
