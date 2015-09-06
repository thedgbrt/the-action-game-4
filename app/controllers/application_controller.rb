class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception

  helper_method :current_player
  helper_method :player_signed_in?
  helper_method :current_team
  helper_method :team_selected?
  helper_method :correct_player?
  helper_method :back_or_home
  helper_method :last_action

  around_filter :user_time_zone, if: :current_player

  private
    def last_action
      current_player.aktions.order(:timeslot).last
    end

    def current_user
      current_player
    end

    def current_player
      @current_player ||= Player.find_by_id(session[:player_id]) if session[:player_id]
    end

    def player_signed_in?
      return true if current_player
    end

    def correct_player?
      @player = Player.find(params[:id])
      unless current_player == @player
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def current_team
      @current_team ||= Team.find_by_id(current_player.current_team_id)
    end

    def team_selected?
      return true if current_player && current_team
    end

    def select_team!
      if !current_team
        redirect_to teams_url, alert: 'Team required.  Please join or create one.'
      end
    end

    def authenticate_player!
      if !current_player
        redirect_to root_url, alert: 'You need to sign in for access to this page.'
      end
    end

    def user_time_zone(&block)
      Time.use_zone(current_player.current_time_zone, &block)
    end

    def back_or_home
      request[:http_referer] || player_path(current_player) || root_path
    end
end
