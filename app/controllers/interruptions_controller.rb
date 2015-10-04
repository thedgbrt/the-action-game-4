class InterruptionsController < ApplicationController
  before_action :set_interruption, only: [:show, :edit, :update, :destroy]

  # GET /interruptions
  # GET /interruptions.json
  def index
    @interruptions = Interruption.all
  end

  # GET /interruptions/1
  # GET /interruptions/1.json
  def show
  end

  # GET /interruptions/new
  def new
    @interruption = Interruption.new
  end

  # GET /interruptions/1/edit
  def edit
  end

  # POST /interruptions
  # POST /interruptions.json
  def create
    @interruption = Interruption.new(interruption_params)

    respond_to do |format|
      if @interruption.save
        format.html { redirect_to @interruption, notice: 'Interruption was successfully created.' }
        format.json { render :show, status: :created, location: @interruption }
      else
        format.html { render :new }
        format.json { render json: @interruption.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interruptions/1
  # PATCH/PUT /interruptions/1.json
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

  # DELETE /interruptions/1
  # DELETE /interruptions/1.json
  def destroy
    @interruption.destroy
    respond_to do |format|
      format.html { redirect_to interruptions_url, notice: 'Interruption was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interruption
      @interruption = Interruption.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interruption_params
      params.require(:interruption).permit(:type, :recovered, :aktion_id, :details)
    end
end
