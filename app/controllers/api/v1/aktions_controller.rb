class Api::V1::AktionsController < Api::V1::BaseController
  def index
    aktions = Aktion.order(:id)

    render(json: aktions)
  end

  def show
    aktion = Aktion.find(params[:id])

    render(json: aktion)
  end
end