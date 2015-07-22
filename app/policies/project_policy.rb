class ProjectPolicy < ApplicationPolicy

  def index?
    true
  end

  def new?
    user.administrator && user.manager?
  end

  def edit?
    user.administrator && user.manager?
  end

  def destroy?
    user.administrator && user.manager?
  end

end