require 'rails_helper'

RSpec.describe CalendlyToken, type: :model do
  let!(:professional) { create(:professional) }
  let(:calendly_token) { CalendlyToken.new(authorization: 'authorization-token', professional_id: professional.id) }

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(calendly_token).to be_valid
    end

    context 'authorization' do
      it 'is invalid if blank' do
        calendly_token.authorization = ''
        expect(calendly_token).to_not be_valid
        expect(calendly_token.errors.to_hash.keys).to include(:authorization)
        expect(calendly_token.errors[:authorization]).to include("can't be blank")
      end

      it 'is invalid if authorization token is invalid' do
        stub_request(:get, 'https://api.calendly.com/users/me')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer invalid-token',
              'Content-Length' => '0',
              'Content-Type' => 'application/json',
              'Host' => 'api.calendly.com',
              'User-Agent' => 'rest-client/2.1.0 (linux x86_64) ruby/3.0.3p157'
            }
          )
          .to_return(status: 401, body: '{
                                          "code": 401,
                                          "status": "401 Unauthorized",
                                          "data": "Unauthorized request! Please try again" }',
                     headers: {})

        calendly_token.authorization = 'invalid-token'
        expect(calendly_token).to_not be_valid
        expect(calendly_token.errors.to_hash.keys).to include(:authorization)
        expect(calendly_token.errors[:authorization]).to include('unauthorized! Please check calendly token.')
      end
    end
  end
end
