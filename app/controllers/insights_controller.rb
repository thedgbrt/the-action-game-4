class InsightsController < ApplicationController
  before_action :authenticate_player!
  before_action :set_insight, only: [:show, :edit, :update, :destroy]

  def index
    @insights = current_player.insights
  end

  def show
  end

  def new
    @insight = Insight.new
  end

  def edit
  end

  def create
    @insight = Insight.new(insight_params)

    respond_to do |format|
      if @insight.save
        format.html { redirect_to @insight, notice: 'Insight was successfully created.' }
        format.json { render :show, status: :created, location: @insight }
      else
        format.html { render :new }
        format.json { render json: @insight.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @insight.update(insight_params)
        format.html { redirect_to @insight, notice: 'Insight was successfully updated.' }
        format.json { render :show, status: :ok, location: @insight }
      else
        format.html { render :edit }
        format.json { render json: @insight.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @insight.destroy
    respond_to do |format|
      format.html { redirect_to insights_url, notice: 'Insight was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_insight
      @insight = Insight.find(params[:id])
    end

    def insight_params
      params.require(:insight).permit(:text, :category, :player_id, :aktion_id)
    end
end
