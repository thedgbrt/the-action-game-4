class TeamsController < ApplicationController
  before_action :authenticate_player!
  before_action :set_team, only: [:show, :edit, :update, :destroy, :join, :leave]

  def index
    @my_teams = current_player.try(:teams)
    @other_teams = Team.all - @my_teams.to_a
  end

  def show
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to teams_path, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @team.update(team_params)
        @current_team = @team
        format.html { redirect_to back_or_home, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to back_or_home, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def activate
    @current_team = Team.find_by_id(params[:id])
    current_player.update_attributes(current_team_id: @current_team.id)
    redirect_to new_team_aktion_path(current_team)
  end

  def join
    raise 'No current player' unless current_player
    msg = @team.add(current_player)
    @current_team = @team
    current_player.update_attributes(current_team_id: @team.id)
    redirect_to back_or_home, msg
  end

  def leave
    raise 'No current player' unless current_player
    msg = @team.remove(current_player)
    redirect_to back_or_home, msg
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:creator_id, :name, :description, :url, :logo_url, :short, :default_color)
    end
end
