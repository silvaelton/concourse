class ProjectSubscribePolicy < ApplicationPolicy

  def new?
    user.administrator? && user.master?
  end

end