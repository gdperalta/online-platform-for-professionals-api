require 'rails_helper'

RSpec.describe '/services', type: :request do
  let(:valid_attributes) do
    attributes_for(:service)
  end

  # let(:invalid_attributes) {
  #   skip("Add a hash of attributes invalid for your model")
  # }
  let!(:professional) { create(:professional, :with_services) }
  let(:valid_headers) do
    post '/login', params: { user: { email: 'pro@email.com', password: 'password' } }
    { 'Accept': 'application/json', 'Authorization': response.headers['Authorization'] }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get professional_services_url(professional), headers: valid_headers, as: :json
      data = response.parsed_body['data']

      expect(response).to be_successful
      expect(data).to_not be_nil
      expect(data).to_not be_empty
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get professional_service_url(professional, professional.services.first), headers: valid_headers, as: :json
      data = response.parsed_body['data']
      attributes = response.parsed_body['data']['attributes']

      expect(response).to be_successful
      expect(data).to include('id')
      expect(data).to include('attributes')
      expect(attributes).to include('title' => 'My Service',
                                    'details' => 'Service Details',
                                    'minPrice' => 50.0,
                                    'maxPrice' => 100.0)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Service' do
        expect do
          post professional_services_url(professional),
               params: { service: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Service, :count).by(1)
      end

      it 'renders a JSON response with the new service' do
        post professional_services_url(professional),
             params: { service: valid_attributes }, headers: valid_headers, as: :json
        data = response.parsed_body['data']
        attributes = response.parsed_body['data']['attributes']

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(data).to include('id')
        expect(data).to include('attributes')
        expect(attributes).to include('title' => 'My Service',
                                      'details' => 'Service Details',
                                      'minPrice' => 50.0,
                                      'maxPrice' => 100.0)
      end
    end

    #   context 'with invalid parameters' do
    #     it 'does not create a new Service' do
    #       expect do
    #         post services_url,
    #              params: { service: invalid_attributes }, as: :json
    #       end.to change(Service, :count).by(0)
    #     end

    #     it 'renders a JSON response with errors for the new service' do
    #       post services_url,
    #            params: { service: invalid_attributes }, headers: valid_headers, as: :json
    #       expect(response).to have_http_status(:unprocessable_entity)
    #       expect(response.content_type).to match(a_string_including('application/json'))
    #     end
    #   end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { title: 'New title', details: 'New details', min_price: 5.0, max_price: 15.0 }
      end

      it 'updates the requested service' do
        service = professional.services.last
        patch professional_service_url(professional, service),
              params: { service: new_attributes }, headers: valid_headers, as: :json
        service.reload
        expect(service.title).to eql('New title')
        expect(service.details).to eql('New details')
        expect(service.min_price).to eql(5.0)
        expect(service.max_price).to eql(15.0)
      end

      it 'renders a JSON response with the service' do
        service = professional.services.last
        patch professional_service_url(professional, service),
              params: { service: new_attributes }, headers: valid_headers, as: :json

        data = response.parsed_body['data']
        attributes = response.parsed_body['data']['attributes']

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(data).to include('id')
        expect(data).to include('attributes')
        expect(attributes).to include('title' => 'New title',
                                      'details' => 'New details',
                                      'minPrice' => 5.0,
                                      'maxPrice' => 15.0)
      end
    end

    # context 'with invalid parameters' do
    #   it 'renders a JSON response with errors for the service' do
    #     service = Service.create! valid_attributes
    #     patch service_url(service),
    #           params: { service: invalid_attributes }, headers: valid_headers, as: :json
    #     expect(response).to have_http_status(:unprocessable_entity)
    #     expect(response.content_type).to match(a_string_including('application/json'))
    #   end
    # end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested service' do
      service = professional.services.last
      expect do
        delete professional_service_url(professional, service), headers: valid_headers, as: :json
      end.to change(Service, :count).by(-1)
    end
  end
end
