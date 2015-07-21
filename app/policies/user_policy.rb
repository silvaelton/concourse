class UserPolicy < ApplicationPolicy

  def administrator?
    user.administrator?
  end


end