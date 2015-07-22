class FormsController < ApplicationController
  layout 'layouts/show_project'
  before_action :set_project
  before_action :set_subscribe

  def new
    @form = "Form::#{@subscribe.form_code.humanize}".constantize.new
  end

  def create
    @form = "Form::#{@subscribe.form_code.humanize}".constantize.new(set_params)
    
    if @form.valid?
    else
      render action: 'new'
    end
  end
    
  private

  def set_params
  end

  def set_project
    @project = Project.friendly.find(params[:project_id])
  end

  def set_subscribe
    @subscribe = @project.project_subscribes.find(params[:project_subscribe_id])
  end
end