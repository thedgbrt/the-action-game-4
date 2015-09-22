class AktionsController < ApplicationController
  before_action :set_aktion, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_player!
  # before_action :select_team!

  def index
    @player = Player.find_by_id(params[:player_id]) || current_player
    if params[:role_id]
      @aktions = @player.aktions.select{ |a| a.role_id == params[:role_id].to_i}.try(:by_timeslot)
    else
      @aktions = @player.aktions.try(:by_timeslot)
    end
    @todays_actions = @player.todays_actions(@date)
  end

  def show
  end

  def new
    if !params[:team_id] && current_player.teams.count == 1
      params[:team_id] = current_player.teams.first.id
    end
    @aktion = @current_player.aktions.new
    @aktion.team_id = params[:team_id]
    @aktion.intensity = 4
    @aktion.timeslot = params[:timeslot] || Aktion.current_timeslot
    @aktion.time_zone = @current_player.current_time_zone
    if params[:status] == 'planned'
      @aktion.planned = true
      @aktion.status = :planned
      @aktion.planned_date = Time.zone.now.to_date
    else
      @aktion.status = :committing
    end
    if params[:previous_aktion_id]
      @old = Aktion.find_by_id(params[:previous_aktion_id])
      @aktion.team = @old.team
      @aktion.verb = @old.verb
      @aktion.role = @old.role
      @aktion.project = @old.project
      # @aktion.intensity = @old.intensity
    end
  end

  def edit
    @aktion.planned_date = Time.zone.now.to_date if @aktion.planned && !@aktion.planned_date
  end

  def create
    @aktion = Aktion.new(aktion_params)
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
      params.require(:aktion).permit(:timeslot, :focus, :player_id, :verb_id, :project_id, :flow, 
        :flow_notes, :value, :value_notes, :visible_to, :status, :intensity, :how_it_went, :music,
        :time_zone, :location_id, :role_id, :properties, :team_id, :water, :breaths, :pushups,
        :wallsits, :choice, :snack, :tidy, :stop, :restroom, :stretch, :games, :friends, :other,
        :change, :planned_date, :planned_sequence_number, :planned, :interruptions, :deflected,
        :distractions, :recovered, :started_at, :stopped_at, :declared_focus)
    end

    def aktion_form
      edit_aktion_path(@aktion)
    end
end
