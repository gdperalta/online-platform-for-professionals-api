class ProfessionalPolicy < ApplicationPolicy
  def create?
    user.professional? && user == professional.user
  end

  def update?
    user.professional? && user == professional.user
  end

  def destroy?
    user.professional? && user == professional.user
  end

  private

  def professional
    record
  end
end
