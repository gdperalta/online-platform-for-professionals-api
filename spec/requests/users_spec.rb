require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user, :admin) }
  let!(:professional) { create(:professional) }

  let(:valid_headers) do
    post '/login', params: { user: { email: 'admin@email.com', password: 'password' } }
    { 'Accept': 'application/json', 'Authorization': response.headers['Authorization'] }
  end
  describe 'PATCH /approve' do
    it 'approves the user' do
      expect do
        patch approve_user_path(professional), headers: valid_headers, as: :json
        professional.reload
      end.to change { professional.user.approved }.from(false).to(true)
    end
  end
end
