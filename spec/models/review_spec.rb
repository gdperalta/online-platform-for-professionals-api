require 'rails_helper'

RSpec.describe Review, type: :model do
  let!(:professional) { create(:professional) }
  let!(:client) { create(:user, :client).client }
  let(:review) { build(:review, client_id: client.id, professional_id: professional.id) }

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(review).to be_valid
    end

    context 'rating' do
      it 'is invalid if not a number' do
        review.rating = 'Five'
        expect(review).to_not be_valid
        expect(review.errors.to_hash.keys).to include(:rating)
        expect(review.errors[:rating]).to include('is not a number')
      end

      it 'is invalid if it is a decimal' do
        review.rating = 4.4
        expect(review).to_not be_valid
        expect(review.errors.to_hash.keys).to include(:rating)
        expect(review.errors[:rating]).to include('must be an integer')
      end

      it 'is invalid if it is a negative number' do
        review.rating = -2
        expect(review).to_not be_valid
        expect(review.errors.to_hash.keys).to include(:rating)
        expect(review.errors[:rating]).to include('must be greater than or equal to 0')
      end

      it 'is invalid if it is not between 1 to 5' do
        review.rating = 10
        expect(review).to_not be_valid
        expect(review.errors.to_hash.keys).to include(:rating)
        expect(review.errors[:rating]).to include('must be less than or equal to 5')
      end
    end
  end
end
