require 'rails_helper'

RSpec.describe Connection, type: :model do
  let!(:professional) { create(:professional) }
  let!(:client) { create(:user, :client).client }
  let!(:connection) do
    Connection.new(professional_id: professional.id, client_id: client.id)
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      connection.classification = 'subscription'
      expect(connection).to be_valid

      connection.classification = 'client_list'
      expect(connection).to be_valid
    end

    context 'subscription' do
      it 'is invalid if the subscription already exists' do
        Connection.create(professional_id: professional.id, client_id: client.id,
                          classification: 'subscription')
        connection.classification = 'subscription'
        expect(connection).to_not be_valid
        expect(connection.errors.to_hash.keys).to include(:professional_id)
        expect(connection.errors[:professional_id]).to include('subscription already exists')
      end
    end

    context 'client_list' do
      it 'is invalid if the client has already been added' do
        Connection.create(professional_id: professional.id, client_id: client.id,
                          classification: 'client_list')
        connection.classification = 'client_list'
        expect(connection).to_not be_valid
        expect(connection.errors.to_hash.keys).to include(:client_id)
        expect(connection.errors[:client_id]).to include('already added to list')
      end
    end
  end
end
