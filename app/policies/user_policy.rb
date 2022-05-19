class UserPolicy < ApplicationPolicy
  def approve?
    user.admin?
  end
end
