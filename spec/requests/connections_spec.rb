require 'rails_helper'

RSpec.describe '/connections', type: :request do
  let!(:professional) { create(:professional) }
  let!(:client) { create(:user, :client).client }

  let(:valid_attributes) do
    { client_id: client.id, professional_id: professional.id }
  end

  # let(:invalid_attributes) do
  #   skip('Add a hash of attributes invalid for your model')
  # end

  let(:client_valid_headers) do
    post '/login', params: { user: { email: 'client@email.com', password: 'password' } }
    { 'Accept': 'application/json', 'Authorization': response.headers['Authorization'] }
  end

  let(:professional_valid_headers) do
    post '/login', params: { user: { email: 'pro@email.com', password: 'password' } }
    { 'Accept': 'application/json', 'Authorization': response.headers['Authorization'] }
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Connection' do
        expect do
          post connections_url,
               params: { connection: valid_attributes }, headers: client_valid_headers, as: :json
        end.to change(Connection, :count).by(1)
      end

      context 'Client connection' do
        it 'renders a JSON response with the classification subscription' do
          post connections_url,
               params: { connection: valid_attributes }, headers: client_valid_headers, as: :json

          data = response.parsed_body['data']
          attributes = response.parsed_body['data']['attributes']

          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including('application/json'))
          expect(data).to include('id')
          expect(data).to include('attributes')
          expect(attributes).to include('classification' => 'subscription',
                                        'professionalId' => professional.id,
                                        'clientId' => client.id)
        end
      end

      context 'Professional connection' do
        it 'renders a JSON response with the classification client_list' do
          post connections_url,
               params: { connection: valid_attributes }, headers: professional_valid_headers, as: :json

          data = response.parsed_body['data']
          attributes = response.parsed_body['data']['attributes']

          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including('application/json'))
          expect(data).to include('id')
          expect(data).to include('attributes')
          expect(attributes).to include('classification' => 'client_list',
                                        'professionalId' => professional.id,
                                        'clientId' => client.id)
        end
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested connection' do
      connection = Connection.create(client_id: client.id, professional_id: professional.id,
                                     classification: 'subscription')
      expect do
        delete connection_url(connection), headers: client_valid_headers, as: :json
      end.to change(Connection, :count).by(-1)
    end
  end

  context 'Various connections' do
    before do
      Connection.create(professional_id: professional.id, client_id: client.id, classification: 'subscription')
      Connection.create(professional_id: professional.id, client_id: client.id, classification: 'client_list')
    end

    describe 'GET /subscribers' do
      it 'renders a successful response' do
        get subscribers_path, headers: professional_valid_headers, as: :json
        data = response.parsed_body['data']
        expect(response).to be_successful
        expect(data).to_not be_nil
        expect(data).to_not be_empty
        expect(data.first).to include('id')
        expect(data.first).to include('attributes')
      end
    end
    describe 'GET /clientele' do
      it 'renders a successful response' do
        get clientele_path, headers: professional_valid_headers, as: :json
        data = response.parsed_body['data']
        expect(response).to be_successful
        expect(data).to_not be_nil
        expect(data).to_not be_empty
        expect(data.first).to include('id')
        expect(data.first).to include('attributes')
      end
    end

    describe 'GET /subscribed_to' do
      it 'renders a successful response' do
        get subscribed_to_path, headers: client_valid_headers, as: :json
        data = response.parsed_body['data']
        expect(response).to be_successful
        expect(data).to_not be_nil
        expect(data).to_not be_empty
        expect(data.first).to include('id')
        expect(data.first).to include('attributes')
      end
    end

    describe 'GET /my_professionals' do
      it 'renders a successful response' do
        get my_professionals_path, headers: client_valid_headers, as: :json
        data = response.parsed_body['data']
        expect(response).to be_successful
        expect(data).to_not be_nil
        expect(data).to_not be_empty
        expect(data.first).to include('id')
        expect(data.first).to include('attributes')
      end
    end
  end
end
