class WorkPortfolioPolicy < ApplicationPolicy
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
