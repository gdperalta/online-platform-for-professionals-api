class BookingPolicy < ApplicationPolicy
  def show?
    user == record.client.user || user == record.professional.user
  end

  def create?
    user.professional? && user == record.professional.user
  end

  def update?
    user.professional? && user == record.professional.user
  end

  def destroy?
    user.professional? && user == record.professional.user
  end
end
