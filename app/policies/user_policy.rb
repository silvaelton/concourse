class UserPolicy < ApplicationPolicy

  def administrator?
    user.administrator?
  end

  def candidate?
    !user.administrator?
  end

end