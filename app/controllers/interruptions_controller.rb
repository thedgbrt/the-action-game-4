class InterruptionsController < ApplicationController
  before_action :set_interruption, only: [:show, :edit, :update, :destroy]

  def index
    @interruptions = Interruption.all
  end

  def show
  end

  def new
    @interruption = Interruption.create!(aktion_id: params[:aktion_id], recovered: params[:recovered], internal: params[:internal])
    redirect_to :back
  end

  def edit
  end

  def create
    @interruption = Interruption.create!(interruption_params)
  end

  def update
    respond_to do |format|
      if @interruption.update(interruption_params)
        format.html { redirect_to @interruption, notice: 'Interruption was successfully updated.' }
        format.json { render :show, status: :ok, location: @interruption }
      else
        format.html { render :edit }
        format.json { render json: @interruption.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @interruption.destroy
    respond_to do |format|
      format.html { redirect_to interruptions_url, notice: 'Interruption was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_interruption
      @interruption = Interruption.find(params[:id])
    end

    def interruption_params
      params.require(:interruption).permit(:type, :recovered, :aktion_id, :details)
    end
end
