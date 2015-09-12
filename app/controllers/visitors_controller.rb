class VisitorsController < ApplicationController
  def index
  end
  
  def help
  end

  def sounds
    sound = params[:sound_choice]
    session[:sound_choice] = sound
    current_player.persist_sound_choice(sound) if player_signed_in?
    redirect_to :back
  end
end
