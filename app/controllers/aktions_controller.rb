class AktionsController < ApplicationController
  before_action :set_aktion, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_player!
  # before_action :select_team!

  def index
    if params[:role_id]
      @aktions = @current_player.aktions.select{ |a| a.role_id == params[:role_id].to_i}
    else
      @aktions = @current_player.aktions
    end
    @todays_actions = @current_player.todays_actions
  end

  def show
  end

  def new
    @aktion = @current_player.aktions.new
    @aktion.team_id = params[:team_id] || current_team.id
    @aktion.intensity = 4
    @aktion.timeslot = params[:timeslot] || Aktion.current_timeslot
    @aktion.time_zone = @current_player.current_time_zone
    if params[:status] == 'planned'
      @aktion.planned = true
      @aktion.status = :planned
      @aktion.planned_date = Time.zone.to_date
    else
      @aktion.status = :committing
    end
    if params[:previous_aktion_id]
      @old = Aktion.find_by_id(params[:previous_aktion_id])
      @current_team = @old.team
      @aktion.team = @old.team
      @aktion.verb = @old.verb
      @aktion.role = @old.role
      @aktion.project = @old.project
      # @aktion.intensity = @old.intensity
    end
  end

  def edit
    @aktion.team_id = current_team.id unless @aktion.team_id
    @aktion.planned_date = Time.zone.to_date if @aktion.planned && !@aktion.planned_date
  end

  def create
    @aktion = Aktion.new(aktion_params)
    @aktion.team_id = current_team.id
    @aktion.status = :attempting
    respond_to do |format|
      if @aktion.save
        format.html { redirect_to aktion_form }
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
        if params[:commit] == 'COUNT IT'
          @aktion.update_attributes(status: :reviewed, completed: true)
        elsif params[:commit] == 'MISSED IT'
          @aktion.update_attributes(status: :reviewed, completed: false)
        elsif params[:commit] == 'FINISH'
          @aktion.update_attributes(status: :finished)          
        end
        format.html { redirect_to aktion_form }
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
        :team_id, :water, :breaths, :pushups, :choice, :snack, :tidy, :stop, :restroom, :stretch, :games, :friends,
        :other, :music, :planned_date, :planned_sequence_number, :planned)
    end

    def aktion_form
      edit_team_aktion_path(@aktion, team_id: current_team.id)
    end
end
