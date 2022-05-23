require 'rails_helper'

RSpec.describe Professional, type: :model do
  let(:professional) { build(:professional) }
  context 'validations' do
    it 'is valid with valid attributes' do
      expect(professional).to be_valid
    end

    context 'user_id' do
      it 'is invalid if is not unique' do
        pro = create(:professional)
        professional.user_id = pro.id
        expect(professional).to_not be_valid
        expect(professional.errors.to_hash.keys).to include(:user_id)
        expect(professional.errors[:user_id]).to include(/has already been taken/)
      end
    end

    context 'license_number' do
      it 'is invalid if blank' do
        professional.license_number = ''
        expect(professional).to_not be_valid
        expect(professional.errors.to_hash.keys).to include(:license_number)
        expect(professional.errors[:license_number]).to include("can't be blank")
      end

      it 'is invalid if the length is not 7' do
        professional.license_number = '12345'
        expect(professional).to_not be_valid
        expect(professional.errors.to_hash.keys).to include(:license_number)
        expect(professional.errors[:license_number]).to include(/should be 7 characters/)
      end

      it 'is invalid if is not unique' do
        pro = create(:professional)
        professional.license_number = pro.license_number
        expect(professional).to_not be_valid
        expect(professional.errors.to_hash.keys).to include(:license_number)
        expect(professional.errors[:license_number]).to include(/has already been taken/)
      end
    end
    context 'field' do
      it 'is invalid if blank' do
        professional.field = ''
        expect(professional).to_not be_valid
        expect(professional.errors.to_hash.keys).to include(:field)
        expect(professional.errors[:field]).to include("can't be blank")
      end

      it 'is an invalid field' do
        professional.field = 'OddJobs'
        expect(professional).to_not be_valid
        expect(professional.errors.to_hash.keys).to include(:field)
        expect(professional.errors[:field]).to include('OddJobs is not a valid field')
      end
    end
  end
end
