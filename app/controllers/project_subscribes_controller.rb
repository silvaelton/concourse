class ProjectSubscribesController < ApplicationController
  layout 'layouts/show_project'
  before_action :set_project
  before_action :set_project_subscribe, only: [:show, :edit, :update, :destroy]

  # GET /project_subscribes
  def index
    @project_subscribes = @project.project_subscribes.unscoped
  end

  # GET /project_subscribes/1
  def show
  end

  # GET /project_subscribes/new
  def new
    @project_subscribe = @project.project_subscribes.new
  end

  # GET /project_subscribes/1/edit
  def edit
  end

  # POST /project_subscribes
  def create
    @project_subscribe = @project.project_subscribes.new(project_subscribe_params)

    if @project_subscribe.save
      flash[:success] = t :success
      redirect_to action: 'index'
    else
      render :new
    end
  end

  # PATCH/PUT /project_subscribes/1
  def update
    if @project_subscribe.update(project_subscribe_params)
      flash[:success] = t :success
      redirect_to action: 'index'
    else
      render :edit
    end
  end

  # DELETE /project_subscribes/1
  def destroy
    if @project_subscribe.destroy
      flash[:success] = t :success
      redirect_to action: 'index'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_subscribe
      @project_subscribe = @project.project_subscribes.unscoped.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_subscribe_params
      params.require(:project_subscribe).permit(:title, :description, :form_code, :start, :end, :fee, :fee_value, :publish)
    end

    def set_project
      @project = Project.friendly.find(params[:project_id])
    end

end
