require 'rails_helper'

RSpec.describe '/work_portfolios', type: :request do
  let(:valid_attributes) do
    attributes_for(:work_portfolio)
  end

  # let(:invalid_attributes) do
  #   skip('Add a hash of attributes invalid for your model')
  # end

  let!(:professional) { create(:professional, :with_work_portfolios) }
  let(:valid_headers) do
    post '/login', params: { user: { email: 'pro@email.com', password: 'password' } }
    { 'Accept': 'application/json', 'Authorization': response.headers['Authorization'] }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get professional_work_portfolios_url(professional), headers: valid_headers, as: :json
      data = response.parsed_body['data']

      expect(response).to be_successful
      expect(data).to_not be_nil
      expect(data).to_not be_empty
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get professional_work_portfolio_url(professional, professional.work_portfolios.first), headers: valid_headers,
                                                                                             as: :json

      data = response.parsed_body['data']
      attributes = response.parsed_body['data']['attributes']

      expect(response).to be_successful
      expect(data).to include('id')
      expect(data).to include('attributes')
      expect(attributes).to include('title' => 'My Work Portfolio',
                                    'details' => 'Work Portfolio Details')
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new WorkPortfolio' do
        expect do
          post professional_work_portfolios_url(professional),
               params: { work_portfolio: valid_attributes }, headers: valid_headers, as: :json
        end.to change(WorkPortfolio, :count).by(1)
      end

      it 'renders a JSON response with the new work_portfolio' do
        post professional_work_portfolios_url(professional),
             params: { work_portfolio: valid_attributes }, headers: valid_headers, as: :json
        data = response.parsed_body['data']
        attributes = response.parsed_body['data']['attributes']

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(data).to include('id')
        expect(data).to include('attributes')
        expect(attributes).to include('title' => 'My Work Portfolio',
                                      'details' => 'Work Portfolio Details')
      end
    end

    # context 'with invalid parameters' do
    #   it 'does not create a new WorkPortfolio' do
    #     expect do
    #       post work_portfolios_url,
    #            params: { work_portfolio: invalid_attributes }, as: :json
    #     end.to change(WorkPortfolio, :count).by(0)
    #   end

    #   it 'renders a JSON response with errors for the new work_portfolio' do
    #     post work_portfolios_url,
    #          params: { work_portfolio: invalid_attributes }, headers: valid_headers, as: :json
    #     expect(response).to have_http_status(:unprocessable_entity)
    #     expect(response.content_type).to match(a_string_including('application/json'))
    #   end
    # end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { title: 'New title', details: 'New details' }
      end

      it 'updates the requested work_portfolio' do
        work_portfolio = professional.work_portfolios.last
        patch professional_work_portfolio_url(professional, work_portfolio),
              params: { work_portfolio: new_attributes }, headers: valid_headers, as: :json
        work_portfolio.reload
        expect(work_portfolio.title).to eql('New title')
        expect(work_portfolio.details).to eql('New details')
      end

      it 'renders a JSON response with the work_portfolio' do
        work_portfolio = professional.work_portfolios.last
        patch professional_work_portfolio_url(professional, work_portfolio),
              params: { work_portfolio: new_attributes }, headers: valid_headers, as: :json

        data = response.parsed_body['data']
        attributes = response.parsed_body['data']['attributes']

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(data).to include('id')
        expect(data).to include('attributes')
        expect(attributes).to include('title' => 'New title',
                                      'details' => 'New details')
      end
    end

    # context 'with invalid parameters' do
    #   it 'renders a JSON response with errors for the work_portfolio' do
    #     work_portfolio = WorkPortfolio.create! valid_attributes
    #     patch work_portfolio_url(work_portfolio),
    #           params: { work_portfolio: invalid_attributes }, headers: valid_headers, as: :json
    #     expect(response).to have_http_status(:unprocessable_entity)
    #     expect(response.content_type).to match(a_string_including('application/json'))
    #   end
    # end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested work_portfolio' do
      work_portfolio = professional.work_portfolios.last
      expect do
        delete professional_work_portfolio_url(professional, work_portfolio), headers: valid_headers, as: :json
      end.to change(WorkPortfolio, :count).by(-1)
    end
  end
end
