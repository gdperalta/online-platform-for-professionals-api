class ReviewPolicy < ApplicationPolicy
  def create?
    user.client? && user == record.client.user
  end

  def update?
    user.client? && user == record.client.user
  end

  def destroy?
    user.client? && user == record.client.user
  end
end
