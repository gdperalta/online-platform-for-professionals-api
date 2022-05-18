require 'rails_helper'
require 'rest-client'

RSpec.describe '/calendly_tokens', type: :request do
  let(:valid_attributes) do
    attributes_for(:calendly_token)
  end

  # let(:invalid_attributes) do
  #   skip('Add a hash of attributes invalid for your model')
  # end

  let(:professional) { create(:professional, :with_calendly_token) }
  let(:valid_headers) do
    post '/login', params: { user: { email: 'pro@email.com', password: 'password' } }
    { 'Accept': 'application/json', 'Authorization': response.headers['Authorization'] }
  end

  # describe 'GET /index' do
  #   it 'renders a successful response' do
  #     get professional_calendly_tokens_url, headers: valid_headers, as: :json
  #     data = response.parsed_body['data']

  #     expect(response).to be_successful
  #   end
  # end

  describe 'GET /show' do
    it 'renders a successful response' do
      get professional_calendly_token_url(professional, professional.calendly_token), headers: valid_headers, as: :json
      data = response.parsed_body['data']
      attributes = response.parsed_body['data']['attributes']

      expect(response).to be_successful
      expect(data).to include('id')
      expect(data).to include('attributes')
      expect(attributes).to include('authorization' => 'authorization-token',
                                    'userUri' => 'https://api.calendly.com/users/HHHHHHHHHH',
                                    'organizationUri' => 'https://api.calendly.com/organizations/ZZZZZZZZZZ')
    end
  end

  describe 'POST /create' do
    let(:new_professional) { create(:professional) }
    context 'with valid parameters' do
      it 'creates a new CalendlyToken' do
        expect do
          post professional_calendly_tokens_url(new_professional),
               params: { calendly_token: valid_attributes }, headers: valid_headers, as: :json
        end.to change(CalendlyToken, :count).by(1)
      end

      it 'renders a JSON response with the new calendly_token' do
        post professional_calendly_tokens_url(new_professional),
             params: { calendly_token: valid_attributes }, headers: valid_headers, as: :json
        data = response.parsed_body['data']
        attributes = response.parsed_body['data']['attributes']

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(data).to include('id')
        expect(data).to include('attributes')
        expect(attributes).to include('authorization' => 'authorization-token',
                                      'userUri' => 'https://api.calendly.com/users/HHHHHHHHHH',
                                      'organizationUri' => 'https://api.calendly.com/organizations/ZZZZZZZZZZ')
      end
    end

    #   context 'with invalid parameters' do
    #     it 'does not create a new CalendlyToken' do
    #       expect do
    #         post calendly_tokens_url,
    #              params: { calendly_token: invalid_attributes }, as: :json
    #       end.to change(CalendlyToken, :count).by(0)
    #     end

    #     it 'renders a JSON response with errors for the new calendly_token' do
    #       post calendly_tokens_url,
    #            params: { calendly_token: invalid_attributes }, headers: valid_headers, as: :json
    #       expect(response).to have_http_status(:unprocessable_entity)
    #       expect(response.content_type).to match(a_string_including('application/json'))
    #     end
    #   end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { authorization: 'new-authorization-token' }
      end

      it 'updates the requested calendly_token' do
        calendly_token = professional.calendly_token
        patch professional_calendly_token_url(professional, calendly_token),
              params: { calendly_token: new_attributes }, headers: valid_headers, as: :json
        calendly_token.reload
        expect(calendly_token.authorization).to eql('new-authorization-token')
      end

      it 'renders a JSON response with the calendly_token' do
        calendly_token = professional.calendly_token
        patch professional_calendly_token_url(professional, calendly_token),
              params: { calendly_token: new_attributes }, headers: valid_headers, as: :json
        data = response.parsed_body['data']
        attributes = response.parsed_body['data']['attributes']

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(data).to include('id')
        expect(data).to include('attributes')
        expect(attributes).to include('authorization' => 'new-authorization-token',
                                      'userUri' => 'https://api.calendly.com/users/ABABABABABA',
                                      'organizationUri' => 'https://api.calendly.com/organizations/BBBBBBBBBBBB')
      end
    end

    # context 'with invalid parameters' do
    #   it 'renders a JSON response with errors for the calendly_token' do
    #     calendly_token = CalendlyToken.create! valid_attributes
    #     patch calendly_token_url(calendly_token),
    #           params: { calendly_token: invalid_attributes }, headers: valid_headers, as: :json
    #     expect(response).to have_http_status(:unprocessable_entity)
    #     expect(response.content_type).to match(a_string_including('application/json'))
    #   end
    # end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested calendly_token' do
      calendly_token = professional.calendly_token
      expect do
        delete professional_calendly_token_url(professional, calendly_token), headers: valid_headers,
                                                                              as: :json
      end.to change(CalendlyToken, :count).by(-1)
    end
  end
end
