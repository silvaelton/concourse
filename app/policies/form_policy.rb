class FormPolicy < ApplicationPolicy

  def index?
    true
  end

  def new?(subscribe_id)
    !user.administrator && user.candidate? && !user.candidate_subscribes.where(project_subscribe_id: subscribe_id).present?
  end

end