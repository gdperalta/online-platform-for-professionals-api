require 'rails_helper'

RSpec.describe '/professionals', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Professional. As you add validations to Professional, be sure to
  # adjust the attributes here as well.
  # let(:valid_attributes) do
  #   skip('Add a hash of attributes valid for your model')
  # end

  # let(:invalid_attributes) do
  #   skip('Add a hash of attributes invalid for your model')
  # end

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # ProfessionalsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let!(:professional) { create(:user, :professional) }
  let(:valid_headers) do
    post '/login', params: { user: { email: 'pro@email.com', password: 'password' } }
    { 'Accept': 'application/json', 'Authorization': response.headers['Authorization'] }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get professionals_path, headers: valid_headers
      expect(response).to be_successful
      field = response.parsed_body['data'].first['attributes']['field']
      expect(field).to eq('Electrical Engineer')
    end
  end

  # describe 'GET /show' do
  #   it 'renders a successful response' do
  #     professional = Professional.create! valid_attributes
  #     get professional_url(professional), as: :json
  #     expect(response).to be_successful
  #   end
  # end

  # describe 'POST /create' do
  #   context 'with valid parameters' do
  #     it 'creates a new Professional' do
  #       expect do
  #         post professionals_url,
  #              params: { professional: valid_attributes }, headers: valid_headers, as: :json
  #       end.to change(Professional, :count).by(1)
  #     end

  #     it 'renders a JSON response with the new professional' do
  #       post professionals_url,
  #            params: { professional: valid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:created)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     it 'does not create a new Professional' do
  #       expect do
  #         post professionals_url,
  #              params: { professional: invalid_attributes }, as: :json
  #       end.to change(Professional, :count).by(0)
  #     end

  #     it 'renders a JSON response with errors for the new professional' do
  #       post professionals_url,
  #            params: { professional: invalid_attributes }, headers: valid_headers, as: :json
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

  #     it 'updates the requested professional' do
  #       professional = Professional.create! valid_attributes
  #       patch professional_url(professional),
  #             params: { professional: new_attributes }, headers: valid_headers, as: :json
  #       professional.reload
  #       skip('Add assertions for updated state')
  #     end

  #     it 'renders a JSON response with the professional' do
  #       professional = Professional.create! valid_attributes
  #       patch professional_url(professional),
  #             params: { professional: new_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:ok)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     it 'renders a JSON response with errors for the professional' do
  #       professional = Professional.create! valid_attributes
  #       patch professional_url(professional),
  #             params: { professional: invalid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:unprocessable_entity)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end
  # end

  # describe 'DELETE /destroy' do
  #   it 'destroys the requested professional' do
  #     professional = Professional.create! valid_attributes
  #     expect do
  #       delete professional_url(professional), headers: valid_headers, as: :json
  #     end.to change(Professional, :count).by(-1)
  #   end
  # end
end
