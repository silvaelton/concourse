class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update,:destroy]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  # GET /projects
  def index
    authorize :project, :index?
    @projects = Project.all
  end

  # GET /projects/1
  def show
    render layout: 'show_project'
  end

  # GET /projects/new
  def new
    authorize :project, :new?
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    authorize :project, :edit?
    render layout: 'layouts/show_project'
  end

  # POST /projects
  def create
    authorize :project, :new?
    @project = Project.new(project_params)

    if @project.save
      flash[:success] = t :success
      redirect_to action: 'index'
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    authorize :project, :edit?
    if @project.update(project_params)
      flash[:success] = t :success
      redirect_to @project
    else
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    authorize :project, :destroy?
    if @project.destroy
      flash[:success] = t :success
      redirect_to action: 'index'
    else
      flash[:danger] = t :error
      redirect_to action: 'index'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.unscoped.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(:title, :description, :start, :end, :publish, :status, :image_header, :image_logo, :image_footer)
    end
end
