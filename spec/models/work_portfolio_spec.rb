require 'rails_helper'

RSpec.describe WorkPortfolio, type: :model do
  let!(:professional) { create(:professional) }
  let(:work_portfolio) { build(:work_portfolio) }

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(work_portfolio).to be_valid
    end
    context 'title' do
      it 'is invalid if blank' do
        work_portfolio.title = ''
        expect(work_portfolio).to_not be_valid
        expect(work_portfolio.errors.to_hash.keys).to include(:title)
        expect(work_portfolio.errors[:title]).to include("can't be blank")
      end
    end

    context 'details' do
      it 'is invalid if blank' do
        work_portfolio.details = ''
        expect(work_portfolio).to_not be_valid
        expect(work_portfolio.errors.to_hash.keys).to include(:details)
        expect(work_portfolio.errors[:details]).to include("can't be blank")
      end
    end
  end
end
