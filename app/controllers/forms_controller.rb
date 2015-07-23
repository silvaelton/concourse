class FormsController < ApplicationController
  layout 'layouts/show_project'
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_subscribe

  def new
    @form = "Form::#{@subscribe.form_code.humanize}".constantize.new
    @form.build_candidate_subscribe
  end

  def create
    @form = "Form::#{@subscribe.form_code.humanize}".constantize.new(set_params)
    @form.build_candidate_subscribe(user_id: current_user.id, project_subscribe_id: @subscribe.id)
    
    if @form.save
      redirect_to show_subscribe_candidates_path(@form.candidate_subscribe.id)
    else
      render action: 'new'
    end
  end
    
  private

  def set_params
    params.require(:"form_#{@subscribe.form_code}").permit("Form::#{@subscribe.form_code.humanize}".constantize.new.attributes.keys)
  end

  def set_project
    @project = Project.friendly.find(params[:project_id])
  end

  def set_subscribe
    @subscribe = @project.project_subscribes.find(params[:project_subscribe_id])
  end
end