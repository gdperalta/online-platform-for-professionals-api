require 'rails_helper'

RSpec.describe '/bookings', type: :request do
  let!(:professional) { create(:professional, :with_calendly_token) }
  let!(:client) { create(:user, :client).client }
  before { Connection.create(professional_id: professional.id, client_id: client.id, classification: 'subscription') }

  let(:valid_attributes) do
    attributes_for(:booking, client_id: client.id)
  end

  # let(:invalid_attributes) {
  #   skip("Add a hash of attributes invalid for your model")
  # }

  let(:valid_headers) do
    post '/login', params: { user: { email: 'pro@email.com', password: 'password' } }
    { 'Accept': 'application/json', 'Authorization': response.headers['Authorization'] }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      allow(Time).to receive(:now).and_return Time.new(2022, 5, 19)
      get bookings_url(status: 'active'), headers: valid_headers, as: :json

      data = response.parsed_body['data']

      expect(response).to be_successful
      expect(data).to_not be_empty

      event = data.first
      expect(event).to include('id' => 'ZZZZZZZZZZ')
      expect(event).to include('type' => 'active_events')
      expect(event).to include('attributes')

      attributes = event['attributes']
      expect(attributes).to include('uri' => 'https://api.calendly.com/scheduled_events/ZZZZZZZZZZ',
                                    'name' => '30 Minute Meeting',
                                    'status' => 'active')
    end
  end

  describe 'GET /show' do
    let(:booking) { create(:booking, professional_id: professional.id, client_id: client.id) }

    it 'renders a successful response' do
      get booking_url(booking), headers: valid_headers, as: :json
      data = response.parsed_body['data']
      attributes = response.parsed_body['data']['attributes']
      relationships = response.parsed_body['data']['relationships']

      expect(response).to be_successful
      expect(data).to include('id')
      expect(data).to include('attributes')
      expect(attributes).to include('clientShowedUp' => true,
                                    'eventUuid' => 'MyString',
                                    'inviteeLink' => 'Invitee_link',
                                    'finished' => true)
      expect(relationships).to include('professional',
                                       'client')
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Booking' do
        expect do
          post professional_bookings_url(professional, invitee_email: 'client@email.com'),
               params: { booking: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Booking, :count).by(1)
      end

      it 'renders a JSON response with the new booking' do
        post professional_bookings_url(professional, invitee_email: 'client@email.com'),
             params: { booking: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
        data = response.parsed_body['data']
        attributes = response.parsed_body['data']['attributes']
        relationships = response.parsed_body['data']['relationships']

        expect(data).to include('id')
        expect(data).to include('attributes')
        expect(attributes).to include('clientShowedUp' => true,
                                      'eventUuid' => 'MyString',
                                      'inviteeLink' => 'Invitee_link',
                                      'finished' => true)
        expect(relationships).to include('professional',
                                         'client')
      end

      it 'renders a JSON response with the new booking' do
        valid_attributes[:client_showed_up] = false
        post professional_bookings_url(professional, invitee_email: 'client@email.com'),
             params: { booking: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
        data = response.parsed_body['data']
        attributes = response.parsed_body['data']['attributes']
        relationships = response.parsed_body['data']['relationships']

        expect(data).to include('id')
        expect(data).to include('attributes')
        expect(attributes).to include('clientShowedUp' => false,
                                      'eventUuid' => 'MyString',
                                      'inviteeLink' => 'Invitee_link',
                                      'finished' => true,
                                      'noShowLink' => 'no_show_link')
        expect(relationships).to include('professional',
                                         'client')
      end
    end

    # context 'with invalid parameters' do
    #   it 'does not create a new Booking' do
    #     expect do
    #       post bookings_url,
    #            params: { booking: invalid_attributes }, as: :json
    #     end.to change(Booking, :count).by(0)
    #   end

    #   it 'renders a JSON response with errors for the new booking' do
    #     post bookings_url,
    #          params: { booking: invalid_attributes }, headers: valid_headers, as: :json
    #     expect(response).to have_http_status(:unprocessable_entity)
    #     expect(response.content_type).to match(a_string_including('application/json'))
    #   end
    # end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:no_show_booking) do
        create(:booking, professional_id: professional.id,
                         client_id: client.id, client_showed_up: false,
                         no_show_link: 'no_show_link')
      end

      let(:new_attributes) do
        { client_showed_up: true }
      end

      it 'updates the requested booking' do
        patch booking_url(no_show_booking),
              params: { booking: new_attributes }, headers: valid_headers, as: :json
        no_show_booking.reload
        expect(no_show_booking.client_showed_up).to eql(true)
        expect(no_show_booking.no_show_link).to be_nil
      end

      it 'renders a JSON response with the booking' do
        patch booking_url(no_show_booking),
              params: { booking: new_attributes }, headers: valid_headers, as: :json

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))

        data = response.parsed_body['data']
        attributes = response.parsed_body['data']['attributes']

        expect(data).to include('id')
        expect(data).to include('attributes')
        expect(attributes).to include('clientShowedUp' => true,
                                      'noShowLink' => nil)
      end
    end

    # context 'with invalid parameters' do
    #   it 'renders a JSON response with errors for the booking' do
    #     booking = Booking.create! valid_attributes
    #     patch booking_url(booking),
    #           params: { booking: invalid_attributes }, headers: valid_headers, as: :json
    #     expect(response).to have_http_status(:unprocessable_entity)
    #     expect(response.content_type).to match(a_string_including('application/json'))
    #   end
    # end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested booking' do
      booking = create(:booking, professional_id: professional.id, client_id: client.id)
      expect do
        delete booking_url(booking), headers: valid_headers, as: :json
      end.to change(Booking, :count).by(-1)
    end
  end
end
