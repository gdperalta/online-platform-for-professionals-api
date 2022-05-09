require 'rails_helper'

RSpec.describe '/professionals', type: :request do
  let(:valid_attributes) do
    attributes_for(:professional)
  end

  # let(:invalid_attributes) do
  #   skip('Add a hash of attributes invalid for your model')
  # end

  let!(:professional) { create(:professional) }
  let(:valid_headers) do
    post '/login', params: { user: { email: 'pro@email.com', password: 'password' } }
    { 'Accept': 'application/json', 'Authorization': response.headers['Authorization'] }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get professionals_path, headers: valid_headers
      data = response.parsed_body['data']

      expect(response).to be_successful
      expect(data).to_not be_nil
      expect(data).to_not be_empty
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get professional_path(professional), headers: valid_headers, as: :json
      data = response.parsed_body['data']
      attributes = response.parsed_body['data']['attributes']

      expect(response).to be_successful
      expect(data).to include('id')
      expect(data).to include('attributes')
      expect(attributes).to include('field' => 'Electrical Engineer',
                                    'licenseNumber' => '0012345',
                                    'headline' => 'MyHeadline',
                                    'officeAddress' => 'Office Address')
    end
  end

  describe 'POST /create' do
    let!(:user) { create(:user, :no_association) }
    let(:valid_headers) do
      post '/login', params: { user: { email: 'test@email.com', password: 'password' } }
      { 'Accept': 'application/json', 'Authorization': response.headers['Authorization'] }
    end
    let(:valid_attributes) do
      { field: 'Programmer', license_number: '0098765', headline: 'New Headline', office_address: 'New Address' }
    end
    context 'with valid parameters' do
      it 'creates a new Professional' do
        expect do
          post professionals_url,
               params: { professional: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Professional, :count).by(1)
      end

      it 'renders a JSON response with the new professional' do
        post professionals_url,
             params: { professional: valid_attributes }, headers: valid_headers, as: :json
        data = response.parsed_body['data']
        attributes = response.parsed_body['data']['attributes']

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))

        expect(response).to be_successful
        expect(data).to include('id')
        expect(data).to include('attributes')
        expect(attributes).to include('field' => 'Programmer',
                                      'licenseNumber' => '0098765',
                                      'headline' => 'New Headline',
                                      'officeAddress' => 'New Address')
      end
    end

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
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { field: 'Architect', license_number: '0054321', office_address: 'Quezon City', headline: 'MyText' }
      end

      it 'updates the requested professional' do
        patch professional_path(professional),
              params: { professional: new_attributes }, headers: valid_headers, as: :json
        professional.reload
        expect(professional.field).to eql('Architect')
        expect(professional.license_number).to eql('0054321')
        expect(professional.office_address).to eql('Quezon City')
        expect(professional.headline).to eql('MyText')
      end

      it 'renders a JSON response with the professional' do
        patch professional_url(professional),
              params: { professional: new_attributes }, headers: valid_headers, as: :json

        data = response.parsed_body['data']
        attributes = response.parsed_body['data']['attributes']

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(data).to include('id')
        expect(data).to include('attributes')
        expect(attributes).to include('field' => 'Architect',
                                      'licenseNumber' => '0054321',
                                      'headline' => 'MyText',
                                      'officeAddress' => 'Quezon City')
      end
    end

    # context 'with invalid parameters' do
    #   it 'renders a JSON response with errors for the professional' do
    #     professional = Professional.create! valid_attributes
    #     patch professional_url(professional),
    #           params: { professional: invalid_attributes }, headers: valid_headers, as: :json
    #     expect(response).to have_http_status(:unprocessable_entity)
    #     expect(response.content_type).to match(a_string_including('application/json'))
    #   end
    # end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested professional' do
      expect do
        delete professional_url(professional), headers: valid_headers, as: :json
      end.to change(Professional, :count).by(-1)
    end
  end
end
