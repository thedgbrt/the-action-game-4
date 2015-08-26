class PlayerPolicy
  attr_reader :current_player, :model

  def initialize(current_player, model)
    @current_player = current_player
    @player = model
  end

  def index?
    @current_player.try(:admin?)
  end

  def show?
    @current_player.try(:admin?) or @current_player == @player
  end

  def destroy?
    @current_player.try(:admin?)
  end

end
