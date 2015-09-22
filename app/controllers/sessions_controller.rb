class SessionsController < ApplicationController

  def new
    redirect_to '/auth/google_oauth2'
  end

  def create
    auth = request.env["omniauth.auth"]
    player = Player.where(:provider => auth['provider'],
                      :uid => auth['uid'].to_s).first || Player.create_with_omniauth(auth)
    reset_session
    session[:player_id] = player.id
    player.update_attributes(current_team_id: player.teams.first.id, sound_choice: 'ticking',
      tick_volume: 30, warning_volume: 70, review_before_relax: 'true', commit_length: 3)
    redirect_to welcome_path, :notice => 'Signed in!'
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
