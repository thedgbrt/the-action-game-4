class VisitorsController < ApplicationController
  def contact
  end

  def index
  end

  def help
  end

  def scores
  end

  def sounds
    sound = params[:sound_choice]
    session[:sound_choice] = sound
    current_player.persist_sound_choice(sound) if player_signed_in?
    redirect_to back_or_home
  end

  def welcome
  end
end
