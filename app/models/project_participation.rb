class ProjectParticipation < ActiveRecord::Base
  belongs_to :project
  belongs_to :project_subscribe
  belongs_to :form
end
