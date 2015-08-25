class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception

  helper_method :current_player
  helper_method :player_signed_in?
  helper_method :correct_player?

  private
    def current_user
      current_player
    end

    def current_player
      begin
        @current_player ||= Player.find(session[:player_id]) if session[:player_id]
      rescue Exception => e
        nil
      end
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

    def authenticate_player!
      if !current_player
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end

end
