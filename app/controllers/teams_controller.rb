class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :join, :leave]

  def index
    @my_teams = current_player.teams
    @other_teams = Team.all - current_player.teams
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
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
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
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
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
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def join
    raise 'No current player' unless current_player
    msg = @team.add(current_player)
    redirect_to :back, msg
  end

  def leave
    raise 'No current player' unless current_player
    msg = @team.remove(current_player)
    redirect_to :back, msg
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:captain_id, :name, :description, :url, :logo_url)
    end
end
