require 'rails_helper'

RSpec.describe '/reviews', type: :request do
  let(:valid_attributes) do
    attributes_for(:review)
  end

  # let(:invalid_attributes) do
  #   skip('Add a hash of attributes invalid for your model')
  # end
  let!(:client) { create(:user, :client) }
  let!(:professional) { create(:professional, :with_reviews) }
  let(:valid_headers) do
    post '/login', params: { user: { email: 'pro@email.com', password: 'password' } }
    { 'Accept': 'application/json', 'Authorization': response.headers['Authorization'] }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get professional_reviews_path(1), headers: valid_headers, as: :json
      data = response.parsed_body['data']

      expect(response).to be_successful
      expect(data).to_not be_nil
      expect(data).to_not be_empty
    end
  end

  # describe 'GET /show' do
  #   it 'renders a successful response' do
  #     review = Review.create! valid_attributes
  #     get review_url(review), as: :json
  #     expect(response).to be_successful
  #   end
  # end

  # describe 'POST /create' do
  #   context 'with valid parameters' do
  #     it 'creates a new Review' do
  #       expect do
  #         post reviews_url,
  #              params: { review: valid_attributes }, headers: valid_headers, as: :json
  #       end.to change(Review, :count).by(1)
  #     end

  #     it 'renders a JSON response with the new review' do
  #       post reviews_url,
  #            params: { review: valid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:created)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     it 'does not create a new Review' do
  #       expect do
  #         post reviews_url,
  #              params: { review: invalid_attributes }, as: :json
  #       end.to change(Review, :count).by(0)
  #     end

  #     it 'renders a JSON response with errors for the new review' do
  #       post reviews_url,
  #            params: { review: invalid_attributes }, headers: valid_headers, as: :json
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

  #     it 'updates the requested review' do
  #       review = Review.create! valid_attributes
  #       patch review_url(review),
  #             params: { review: new_attributes }, headers: valid_headers, as: :json
  #       review.reload
  #       skip('Add assertions for updated state')
  #     end

  #     it 'renders a JSON response with the review' do
  #       review = Review.create! valid_attributes
  #       patch review_url(review),
  #             params: { review: new_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:ok)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     it 'renders a JSON response with errors for the review' do
  #       review = Review.create! valid_attributes
  #       patch review_url(review),
  #             params: { review: invalid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:unprocessable_entity)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end
  # end

  # describe 'DELETE /destroy' do
  #   it 'destroys the requested review' do
  #     review = Review.create! valid_attributes
  #     expect do
  #       delete review_url(review), headers: valid_headers, as: :json
  #     end.to change(Review, :count).by(-1)
  #   end
  # end
end
