class TeamMembershipsController < ApplicationController
  before_action :set_team_membership, only: [:show, :edit, :update, :destroy]

  def index
    @team_memberships = TeamMembership.all
  end

  def show
  end

  def new
    @team_membership = TeamMembership.new
  end

  def edit
  end

  def create
    @team_membership = TeamMembership.new(team_membership_params)

    respond_to do |format|
      if @team_membership.save
        format.html { redirect_to @team_membership, notice: 'Team membership was successfully created.' }
        format.json { render :show, status: :created, location: @team_membership }
      else
        format.html { render :new }
        format.json { render json: @team_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @team_membership.update(team_membership_params)
        format.html { redirect_to @team_membership, notice: 'Team membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @team_membership }
      else
        format.html { render :edit }
        format.json { render json: @team_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team_membership.destroy
    respond_to do |format|
      format.html { redirect_to team_memberships_url, notice: 'Team membership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_team_membership
      @team_membership = TeamMembership.find(params[:id])
    end

    def team_membership_params
      params.require(:team_membership).permit(:player_id, :team_id, :active, :admin, :api_key)
    end
end
