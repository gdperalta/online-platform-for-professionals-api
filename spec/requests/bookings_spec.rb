require 'rails_helper'

RSpec.describe '/bookings', type: :request do
  let!(:professional) { create(:professional, :with_calendly_token) }
  let!(:client) { create(:user, :client) }

  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  # let(:invalid_attributes) {
  #   skip("Add a hash of attributes invalid for your model")
  # }

  let(:valid_headers) do
    post '/login', params: { user: { email: 'pro@email.com', password: 'password' } }
    { 'Accept': 'application/json', 'Authorization': response.headers['Authorization'] }
  end

  # describe 'GET /index' do
  #   it 'renders a successful response' do
  #     get professional_bookings_url(professional, status: 'active'), headers: valid_headers, as: :json
  #     p response.parsed_body
  # expect(response).to be_successful

  # response = Calendly::Client.events(professional.calendly_token.authorization, params: { user: professional.calendly_token.user,
  #                                                                                         invitee_email: professional.subscribers.first.user.email,
  #                                                                                         count: 5,
  #                                                                                         min_start_time: '2020-04-24T01:00:00.000000Z' })
  #   end
  # end

  # describe 'GET /show' do
  #   it 'renders a successful response' do
  #     booking = Booking.create! valid_attributes
  #     get booking_url(booking), as: :json
  #     expect(response).to be_successful
  #   end
  # end

  # describe 'POST /create' do
  #   context 'with valid parameters' do
  #     it 'creates a new Booking' do
  #       expect do
  #         post bookings_url,
  #              params: { booking: valid_attributes }, headers: valid_headers, as: :json
  #       end.to change(Booking, :count).by(1)
  #     end

  #     it 'renders a JSON response with the new booking' do
  #       post bookings_url,
  #            params: { booking: valid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:created)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     it 'does not create a new Booking' do
  #       expect do
  #         post bookings_url,
  #              params: { booking: invalid_attributes }, as: :json
  #       end.to change(Booking, :count).by(0)
  #     end

  #     it 'renders a JSON response with errors for the new booking' do
  #       post bookings_url,
  #            params: { booking: invalid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:unprocessable_entity)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end
  # end

  # describe 'PATCH /update' do
  #   context 'with valid parameters' do
  #     let(:new_attributes) do
  #       skip('Add a hash of attributes valid for your model')
  #     end

  #     it 'updates the requested booking' do
  #       booking = Booking.create! valid_attributes
  #       patch booking_url(booking),
  #             params: { booking: new_attributes }, headers: valid_headers, as: :json
  #       booking.reload
  #       skip('Add assertions for updated state')
  #     end

  #     it 'renders a JSON response with the booking' do
  #       booking = Booking.create! valid_attributes
  #       patch booking_url(booking),
  #             params: { booking: new_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:ok)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     it 'renders a JSON response with errors for the booking' do
  #       booking = Booking.create! valid_attributes
  #       patch booking_url(booking),
  #             params: { booking: invalid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:unprocessable_entity)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end
  # end

  # describe 'DELETE /destroy' do
  #   it 'destroys the requested booking' do
  #     booking = Booking.create! valid_attributes
  #     expect do
  #       delete booking_url(booking), headers: valid_headers, as: :json
  #     end.to change(Booking, :count).by(-1)
  #   end
  # end
end
