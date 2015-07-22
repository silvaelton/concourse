class ProjectSubscribe < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :title, :description, :start, :end, :form_code
  validates :fee_value, presence: true, if: :fee?

  validates_date :start, before: :end, after: :start_project
  validates_date :end, before: :end_project
  
  default_scope { where(publish: true) }

  private 

  def fee?
    self.fee
  end

  def start_project
    project.start
  end

  def end_project
    project.end
  end
end
