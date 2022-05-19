class Connection < ApplicationRecord
  belongs_to :professional
  belongs_to :client
  validate :subsctiption_exists?
  validate :client_added?

  def subsctiption_exists?
    return unless classification == 'subscription'

    connection = Connection.find_by(professional_id: professional_id, client_id: client_id,
                                    classification: classification)

    errors.add(:professional_id, 'subscription already exists') unless connection.nil?
  end

  def client_added?
    return unless classification == 'client_list'

    connection = Connection.find_by(professional_id: professional_id, client_id: client_id,
                                    classification: classification)

    errors.add(:client_id, 'already added to list') unless connection.nil?
  end
end
