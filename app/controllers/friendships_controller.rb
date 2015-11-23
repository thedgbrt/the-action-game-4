class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :edit, :update, :destroy]

  def index
    @friendships = Friendship.all
  end

  def show
  end

  def new
    @friendship = Friendship.new
  end

  def edit
  end

  def create
    @friendship = Friendship.new(friendship_params)

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to @friendship, notice: 'Friendship was successfully created.' }
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { render :new }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @friendship.update(friendship_params)
        format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
        format.json { render :show, status: :ok, location: @friendship }
      else
        format.html { render :edit }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to friendships_url, notice: 'Friendship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    def friendship_params
      params.require(:friendship).permit(:requester_id, :accepter_id, :accepted)
    end
end
