class VerbsController < ApplicationController
  before_action :set_verb, only: [:show, :edit, :update, :destroy]

  def index
    @verbs = Verb.all
  end

  def show
  end

  def new
    @verb = Verb.new
  end

  def edit
  end

  def create
    @verb = Verb.new(verb_params)

    respond_to do |format|
      if @verb.save
        format.html { redirect_to @verb, notice: 'Verb was successfully created.' }
        format.json { render :show, status: :created, location: @verb }
      else
        format.html { render :new }
        format.json { render json: @verb.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @verb.update(verb_params)
        format.html { redirect_to @verb, notice: 'Verb was successfully updated.' }
        format.json { render :show, status: :ok, location: @verb }
      else
        format.html { render :edit }
        format.json { render json: @verb.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @verb.destroy
    respond_to do |format|
      format.html { redirect_to verbs_url, notice: 'Verb was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_verb
      @verb = Verb.find(params[:id])
    end

    def verb_params
      params.require(:verb).permit(:name, :description, :intensity, :creator_id, :examples, :level)
    end
end
