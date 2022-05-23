class ConnectionPolicy < ApplicationPolicy
  def create?
    user == record.professional.try(:user) || user == record.client.try(:user)
  end

  def destroy?
    user == record.professional.try(:user) || user == record.client.try(:user)
  end
end
