class AktionsController < ApplicationController
  before_action :set_aktion, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_player!
  # before_action :select_team!

  def index
    @aktions = Aktion.all
  end

  def show
  end

  def new
    @aktion = @current_player.aktions.new
    @aktion.time_zone = @current_player.current_time_zone
    @aktion.timeslot = Aktion.current_timeslot
    @aktion.team = current_team
    @aktion.status = 'committing'
  end

  def edit
  end

  def create
    @aktion = Aktion.new(aktion_params)
    respond_to do |format|
      if @aktion.save
        @aktion.update_attributes(status: 'attempting')
        format.html { redirect_to aktion_form, notice: 'Aktion was successfully created.' }
        format.json { render :show, status: :created, location: @aktion }
      else
        format.html { render :new }
        format.json { render json: @aktion.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @aktion.update(aktion_params)
        format.html { redirect_to aktion_form, notice: 'Aktion was successfully updated.' }
        format.json { render :show, status: :ok, location: @aktion }
      else
        format.html { render :edit }
        format.json { render json: @aktion.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @aktion.destroy
    respond_to do |format|
      format.html { redirect_to aktions_url, notice: 'Aktion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_aktion
      @aktion = Aktion.find(params[:id])
    end

    def aktion_params
      params.require(:aktion).permit(:timeslot, :focus, :player_id, :verb_id, :project_id, :flow, :flow_notes, :value,
        :value_notes, :visible_to, :status, :intensity, :how_it_went, :time_zone, :location_id, :role_id, :properties,
        :team_id, :water, :breaths, :pushups)
    end

    def aktion_form
      edit_team_aktion_path(@aktion, team_id: current_team.id)
    end
end
