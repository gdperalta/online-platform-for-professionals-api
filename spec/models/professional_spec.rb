require 'rails_helper'

RSpec.describe Professional, type: :model do
  let(:professional) { build(:professional) }
  context 'validations' do
    it 'is valid with valid attributes' do
      expect(professional).to be_valid
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
        create(:professional)
        professional.license_number = '0012345'
        expect(professional).to_not be_valid
        expect(professional.errors.to_hash.keys).to include(:license_number)
        expect(professional.errors[:license_number]).to include(/has already been taken/)
      end
    end
  end
end
