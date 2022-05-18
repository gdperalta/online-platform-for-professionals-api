class BookingPolicy < ApplicationPolicy
  def index?
    user.professional? && user == record.user
  end

  def show?
    user.professional? && user == record.professional.user
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
