class PlayersController < ApplicationController
  before_action :authenticate_player!, except: [:index]
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  def index
    @players = Player.all
  end

  def show
    @current_team ||= current_team
  end

  def edit
  end

  def update
    respond_to do |format|
      if @player.update(player_params)
        session[:sound_choice] = @player.sound_choice
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit(:name, :role, :email, :current_time_zone, :email, :fictional,
        :current_team_id, :sound_choice, :tick_volume, :warning_volume)
    end
end
