class NavsController < ApplicationController
  before_action :set_nav, only: [:show, :edit, :update, :destroy]
  before_action :set_project
  # GET /navs
  def index
    @navs = Nav.all
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
      redirect_to @nav, notice: 'Nav was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /navs/1
  def update
    if @nav.update(nav_params)
      redirect_to @nav, notice: 'Nav was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /navs/1
  def destroy
    @nav.destroy
    redirect_to navs_url, notice: 'Nav was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nav
      @nav = Nav.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def nav_params
      params[:nav]
    end

    def set_project
      @project = Project.friendly.find(params[:project_id])
    end
end
