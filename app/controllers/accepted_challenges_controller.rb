class AcceptedChallengesController < ApplicationController
  before_action :set_accepted_challenge, only: [:show, :edit, :update, :destroy]

  # GET /accepted_challenges
  # GET /accepted_challenges.json
  def index
    @accepted_challenges = AcceptedChallenge.all
  end

  # GET /accepted_challenges/1
  # GET /accepted_challenges/1.json
  def show
  end

  # GET /accepted_challenges/new
  def new
    @accepted_challenge = AcceptedChallenge.new
  end

  # GET /accepted_challenges/1/edit
  def edit
  end

  # POST /accepted_challenges
  # POST /accepted_challenges.json
  def create
    @accepted_challenge = AcceptedChallenge.new(accepted_challenge_params)

    respond_to do |format|
      if @accepted_challenge.save
        format.html { redirect_to @accepted_challenge, notice: 'Accepted challenge was successfully created.' }
        format.json { render :show, status: :created, location: @accepted_challenge }
      else
        format.html { render :new }
        format.json { render json: @accepted_challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accepted_challenges/1
  # PATCH/PUT /accepted_challenges/1.json
  def update
    respond_to do |format|
      if @accepted_challenge.update(accepted_challenge_params)
        format.html { redirect_to @accepted_challenge, notice: 'Accepted challenge was successfully updated.' }
        format.json { render :show, status: :ok, location: @accepted_challenge }
      else
        format.html { render :edit }
        format.json { render json: @accepted_challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accepted_challenges/1
  # DELETE /accepted_challenges/1.json
  def destroy
    @accepted_challenge.destroy
    respond_to do |format|
      format.html { redirect_to accepted_challenges_url, notice: 'Accepted challenge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accepted_challenge
      @accepted_challenge = AcceptedChallenge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accepted_challenge_params
      params.require(:accepted_challenge).permit(:player_id, :challenge_id, :active, :comments)
    end
end
