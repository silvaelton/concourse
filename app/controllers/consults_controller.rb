class ConsultsController < ApplicationController
  layout 'layouts/show_project'
  before_action :set_project

  def index
    @consults = @project.consults
  end

  def read
  end

  def new
    @consult = @project.consults.new
  end

  def create
    @consult = @project.consults.new(set_params)
    if @consult.save
      flash[:success] = t :consult_save
      redirect_to action: 'new'
    else
      flash[:danger] = t :consult_error
      render action: 'new'
    end
  end

  def save

  end


  private

  def set_params
    params.require(:consult).permit(:title, :content, :status)
  end

  def set_project
    @project = Project.friendly.find(params[:project_id])
  end
end