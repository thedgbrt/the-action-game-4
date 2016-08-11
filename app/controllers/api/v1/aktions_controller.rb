class Api::V1::AktionsController < Api::V1::BaseController
  def index    
    player = Player.find(params[:player_id])
    aktions = player.aktions.order('timeslot DESC')

    render(json: aktions)
  end

  def show
    aktion = Aktion.find(params[:id])

    render(json: aktion)
  end
end