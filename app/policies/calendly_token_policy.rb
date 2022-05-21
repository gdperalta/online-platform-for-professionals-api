class CalendlyTokenPolicy < ApplicationPolicy
  def show?
    user.professional? && user == calendly_token.professional.user
  end

  def create?
    user.professional? && user == calendly_token.professional.user
  end

  def update?
    user.professional? && user == calendly_token.professional.user
  end

  def destroy?
    user.professional? && user == calendly_token.professional.user
  end

  private

  def calendly_token
    record
  end
end
