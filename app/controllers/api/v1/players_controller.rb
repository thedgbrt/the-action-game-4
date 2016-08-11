class Api::V1::PlayersController < Api::V1::BaseController
  def index
    players = Player.order(:id)

    render(json: players)
  end

  def show
    player = Player.find(params[:id])

    render(json: player)
  end
end