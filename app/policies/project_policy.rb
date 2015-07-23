class ProjectPolicy < ApplicationPolicy

  def index?
    true
  end

  def new?
    user.administrator && user.master?
  end

  def edit?
    user.administrator && user.master?
  end

  def destroy?
    user.administrator && user.master?
  end

end