require 'rails_helper'

RSpec.describe Booking, type: :model do
  let!(:professional) { create(:professional, :with_calendly_token) }
  let!(:client) { create(:user, :client).client }
  before { Connection.create(professional_id: professional.id, client_id: client.id, classification: 'subscription') }

  let(:booking) { build(:booking, professional_id: professional.id, client_id: client.id) }

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(booking).to be_valid
    end

    context 'event_uuid' do
      it 'is invalid if blank' do
        booking.event_uuid = ''
        expect(booking).to_not be_valid
        expect(booking.errors.to_hash.keys).to include(:event_uuid)
        expect(booking.errors[:event_uuid]).to include("can't be blank")
      end
    end

    context 'invitee_link' do
      it 'is invalid if blank' do
        booking.invitee_link = ''
        expect(booking).to_not be_valid
        expect(booking.errors.to_hash.keys).to include(:invitee_link)
        expect(booking.errors[:invitee_link]).to include("can't be blank")
      end

      it 'is invalid if the link is incorrect' do
        booking.invitee_link = 'incorrect link'
        booking.client_showed_up = false
        expect(booking).to_not be_valid
        expect(booking.errors.to_hash.keys).to include(:invitee_link)
        expect(booking.errors[:invitee_link]).to include('incorrect')
      end
    end

    context 'no_show_link' do
      let(:booking) do
        create(:booking, professional_id: professional.id,
                         client_id: client.id, client_showed_up: false)
      end

      it 'is invalid if the link is incorrect' do
        booking.no_show_link = 'invalid_show_link'
        booking.client_showed_up = true
        expect(booking).to_not be_valid
        expect(booking.errors.to_hash.keys).to include(:no_show_link)
        expect(booking.errors[:no_show_link]).to include('incorrect')
      end
    end

    context 'time' do
      it 'is invalid if blank' do
        booking.start_time = ''
        expect(booking).to_not be_valid
        expect(booking.errors.to_hash.keys).to include(:start_time)
        expect(booking.errors[:start_time]).to include("can't be blank")

        booking.end_time = ''
        expect(booking).to_not be_valid
        expect(booking.errors.to_hash.keys).to include(:end_time)
        expect(booking.errors[:end_time]).to include("can't be blank")
      end

      it 'is invalid if meeting is not yet finished' do
        booking.end_time = '2100-01-1 11:49:44.719404456 +0800'
        expect(booking).to_not be_valid
        expect(booking.errors.to_hash.keys).to include(:end_time)
        expect(booking.errors[:end_time]).to include('scheduled time is not yet finished')
      end

      it 'is invalid if wrong format' do
        booking.start_time = 'wrong format'
        expect(booking).to_not be_valid
        expect(booking.errors.to_hash.keys).to include(:start_time)
      end
    end

    context 'client_showed_up' do
      it 'is invalid if not boolean' do
        booking.client_showed_up = ''
        expect(booking).to_not be_valid
        expect(booking.errors.to_hash.keys).to include(:client_showed_up)
        expect(booking.errors[:client_showed_up]).to include('is not included in the list')
      end
    end
  end
end
