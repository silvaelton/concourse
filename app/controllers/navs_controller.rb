class NavsController < ApplicationController
  layout 'layouts/show_project'
  before_action :set_project
  before_action :set_nav, only: [:show, :edit, :update, :destroy]
  # GET /navs
  def index
    @navs = @project.navs.unscoped.order(:order)
  end

  # GET /navs/1
  def show
  end

  # GET /navs/new
  def new
    @nav = @project.navs.new
  end

  # GET /navs/1/edit
  def edit
  end

  # POST /navs
  def create
    @nav = @project.navs.new(nav_params)

    if @nav.save
      flash[:success] = t :success
      redirect_to action: 'index'
    else
      render :new
    end
  end

  # PATCH/PUT /navs/1
  def update
    if @nav.update(nav_params)
      flash[:success] = t :success
      redirect_to action: 'index'
    else
      render :edit
    end
  end


  def switch_up
    @nav = @project.navs.unscoped.find(params[:nav_id])
    if @nav.switch_up
      flash[:success] = t :success    
      redirect_to action: 'index'
    else
      flash[:danger] = t :error    
      redirect_to action: 'index'
    end
  end

  def switch_down
    @nav = @project.navs.unscoped.find(params[:nav_id])
    if @nav.switch_down
      flash[:success] = t :success    
      redirect_to action: 'index'
    else
      flash[:danger] = t :error    
      redirect_to action: 'index'
    end
  end

  # DELETE /navs/1
  def destroy
    if @nav.destroy
      flash[:success] = t :success
      redirect_to action: 'index'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nav
      @nav = @project.navs.unscoped.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def nav_params
      params.require(:nav).permit(:title, :nav_type, :page_id, :url, :target, :publish)
    end

    def set_project
      @project = Project.friendly.find(params[:project_id])
    end
end
