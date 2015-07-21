class CandidateSubscribesController < ApplicationController
  before_action :set_candidate_subscribe, only: [:show, :edit, :update, :destroy]

  # GET /candidate_subscribes
  def index
    @candidate_subscribes = CandidateSubscribe.all
  end

  # GET /candidate_subscribes/1
  def show
  end

  # GET /candidate_subscribes/new
  def new
    @candidate_subscribe = CandidateSubscribe.new
  end

  # GET /candidate_subscribes/1/edit
  def edit
  end

  # POST /candidate_subscribes
  def create
    @candidate_subscribe = CandidateSubscribe.new(candidate_subscribe_params)

    if @candidate_subscribe.save
      redirect_to @candidate_subscribe, notice: 'Candidate subscribe was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /candidate_subscribes/1
  def update
    if @candidate_subscribe.update(candidate_subscribe_params)
      redirect_to @candidate_subscribe, notice: 'Candidate subscribe was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /candidate_subscribes/1
  def destroy
    @candidate_subscribe.destroy
    redirect_to candidate_subscribes_url, notice: 'Candidate subscribe was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate_subscribe
      @candidate_subscribe = CandidateSubscribe.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def candidate_subscribe_params
      params[:candidate_subscribe]
    end
end
