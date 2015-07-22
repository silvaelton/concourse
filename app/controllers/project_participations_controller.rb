class ProjectParticipationsController < ApplicationController
  layout 'layouts/show_project'
  before_action :set_project
  before_action :set_project_participation, only: [:show, :edit, :update, :destroy]

  # GET /project_participations
  def index
    @project_participations = @project.project_participations.unscoped
  end

  # GET /project_participations/1
  def show
  end

  # GET /project_participations/new
  def new
    @project_participation =  @project.project_participations.new
  end

  # GET /project_participations/1/edit
  def edit
  end

  # POST /project_participations
  def create
    @project_participation =  @project.project_participations.new(project_participation_params)

    if @project_participation.save
      flash[:success] = t :success 
      redirect_to action: 'index'
    else
      render :new
    end
  end

  # PATCH/PUT /project_participations/1
  def update
    if @project_participation.update(project_participation_params)
      flash[:success] = t :success 
      redirect_to action: 'index'
    else
      render :edit
    end
  end

  # DELETE /project_participations/1
  def destroy
    if @project_participation.destroy
      flash[:success] = t :success 
      redirect_to action: 'index'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_participation
      @project_participation =  @project.project_participations.unscoped.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_participation_params
      params.require(:project_participation).permit(:title, :project_subscribe_id, :start, :end, :form_code, :publish)
    end

    def set_project
      @project = Project.friendly.find(params[:project_id])
    end
end
