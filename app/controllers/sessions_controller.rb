class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

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
      ticking_volume: 30, warning_volume: 70, review_before_relax: 'true', commit_length: 3,
      show_sidebars: '1', show_insights: '0', show_rubric: 1)
    redirect_to edit_player_path(player), :notice => 'Signed in!'
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
