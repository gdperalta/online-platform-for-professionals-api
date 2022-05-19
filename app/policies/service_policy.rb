class ServicePolicy < ApplicationPolicy
  def create?
    user.professional? && user == service.professional.user
  end

  def update?
    user.professional? && user == service.professional.user
  end

  def destroy?
    user.professional? && user == service.professional.user
  end

  private

  def service
    record
  end
end
