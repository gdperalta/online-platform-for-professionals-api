class ClientPolicy < ApplicationPolicy
  def destroy?
    user.client? && user == client.user
  end

  private

  def client
    record
  end
end
