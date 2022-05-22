require 'rails_helper'

RSpec.describe Field, type: :model do
  let!(:field) {create(:field)} 
  context 'validations' do
    it 'is valid with valid attributes' do
      expect(field).to be_valid
    end
  end
  context 'name' do
    it 'is invalid if blank' do
      field.name = ''
      expect(field).to_not be_valid
      expect(field.errors.to_hash.keys).to include(:name)
      expect(field.errors[:name]).to include("can't be blank")
    end
  end
end
