require 'rails_helper'

RSpec.describe '/clients', type: :request do
  let!(:client) { create(:user, :client).client }
  let(:valid_headers) do
    post '/login', params: { user: { email: 'client@email.com', password: 'password' } }
    { 'Accept': 'application/json', 'Authorization': response.headers['Authorization'] }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get clients_url, headers: valid_headers
      data = response.parsed_body['data']

      expect(response).to be_successful
      expect(data).to_not be_nil
      expect(data).to_not be_empty
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get client_url(client), headers: valid_headers, as: :json
      data = response.parsed_body['data']
      attributes = response.parsed_body['data']['attributes']
      relationships = response.parsed_body['data']['relationships']

      expect(response).to be_successful
      expect(data).to include('id')
      expect(data).to include('attributes')
      expect(attributes).to include('user_id' => 2)
      expect(relationships).to include('user',
                                       'reviews')
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested professional' do
      expect do
        delete client_url(client), headers: valid_headers, as: :json
        expect(response).to have_http_status(:no_content)
      end.to change(Client, :count).by(-1)
    end
  end
end
