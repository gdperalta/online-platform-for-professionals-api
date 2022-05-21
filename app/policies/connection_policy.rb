class ConnectionPolicy < ApplicationPolicy
  def create?
    user == record.professional.user || user == record.client.user
  end

  def destroy?
    user == record.professional.user || user == record.client.user
  end
end
