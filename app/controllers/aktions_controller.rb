class AktionsController < ApplicationController
  before_action :set_aktion, only: [:show, :edit, :update, :destroy]

  # GET /aktions
  # GET /aktions.json
  def index
    @aktions = Aktion.all
  end

  # GET /aktions/1
  # GET /aktions/1.json
  def show
  end

  # GET /aktions/new
  def new
    @aktion = Aktion.new
  end

  # GET /aktions/1/edit
  def edit
  end

  # POST /aktions
  # POST /aktions.json
  def create
    @aktion = Aktion.new(aktion_params)

    respond_to do |format|
      if @aktion.save
        format.html { redirect_to @aktion, notice: 'Aktion was successfully created.' }
        format.json { render :show, status: :created, location: @aktion }
      else
        format.html { render :new }
        format.json { render json: @aktion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aktions/1
  # PATCH/PUT /aktions/1.json
  def update
    respond_to do |format|
      if @aktion.update(aktion_params)
        format.html { redirect_to @aktion, notice: 'Aktion was successfully updated.' }
        format.json { render :show, status: :ok, location: @aktion }
      else
        format.html { render :edit }
        format.json { render json: @aktion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aktions/1
  # DELETE /aktions/1.json
  def destroy
    @aktion.destroy
    respond_to do |format|
      format.html { redirect_to aktions_url, notice: 'Aktion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aktion
      @aktion = Aktion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def aktion_params
      params.require(:aktion).permit(:timeslot, :focus, :player_id, :verb_id, :project_id, :flow, :flow_notes, :value, :value_notes, :visible_to, :status, :intensity, :how_it_went, :time_zone, :location_id, :role_id, :properties)
    end
end
