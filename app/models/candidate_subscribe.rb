class CandidateSubscribe < ActiveRecord::Base
  belongs_to :project_subscribe
  belongs_to :user
  belongs_to :form, polymorphic: true

  enum :status => [:waiting, :success, :error]
end
