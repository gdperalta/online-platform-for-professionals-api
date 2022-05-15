require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    let(:user) { build(:user, :professional) }

    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    context 'first_name' do
      it 'is invalid if blank' do
        user.first_name = ''
        expect(user).to_not be_valid
        expect(user.errors.to_hash.keys).to include(:first_name)
        expect(user.errors[:first_name]).to include("can't be blank")
      end
    end

    context 'last_name' do
      it 'is invalid without last_name ' do
        user.last_name = ''
        expect(user).to_not be_valid
        expect(user.errors.to_hash.keys).to include(:last_name)
        expect(user.errors[:last_name]).to include("can't be blank")
      end
    end

    context 'contact_number' do
      it 'is invalid if blank' do
        user.contact_number = ''
        expect(user).to_not be_valid
        expect(user.errors.to_hash.keys).to include(:contact_number)
        expect(user.errors[:contact_number]).to include("can't be blank")
      end

      it 'is invalid if the length is not 10' do
        user.contact_number = '915'
        expect(user).to_not be_valid
        expect(user.errors.to_hash.keys).to include(:contact_number)
        expect(user.errors[:contact_number]).to include(/should be 10 characters/)
      end

      it 'is invalid if is not unique' do
        create(:user, :client)
        user.contact_number = '9151239876'
        expect(user).to_not be_valid
        expect(user.errors.to_hash.keys).to include(:contact_number)
        expect(user.errors[:contact_number]).to include(/has already been taken/)
      end
    end

    context 'role' do
      it 'is invalid if blank' do
        user.role = ''
        expect(user).to_not be_valid
        expect(user.errors.to_hash.keys).to include(:role)
        expect(user.errors[:role]).to include("can't be blank")
      end

      it 'is an invalid role ' do
        user.role = 'OwnRole'
        expect(user).to_not be_valid
        expect(user.errors.to_hash.keys).to include(:role)
        expect(user.errors[:role]).to include('OwnRole is not a valid role')
      end
    end
  end
end
