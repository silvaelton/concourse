class ProjectPolicy < ApplicationPolicy

  def index?
    true
  end

  def new?
    true
  end

  def edit?
    true
  end

  def destroy?
    true
  end

end