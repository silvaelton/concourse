class ProjectParticipation < ActiveRecord::Base
  belongs_to :project
  belongs_to :project_subscribe

  validates_presence_of :project_subscribe, :title, :form_code, :start, :end
  validates_date :start, before: :end, after: :date_subscribe?

  default_scope { where(publish: true) }
  
  private

  def date_subscribe?
    project_subscribe.end
  end
end
