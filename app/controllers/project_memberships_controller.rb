class ProjectMembershipsController < ApplicationController
  before_action :set_project_membership, only: [:show, :edit, :update, :destroy]

  def index
    @project_memberships = ProjectMembership.all
  end

  def show
  end

  def new
    ProjectMembership.create!(project_id: params[:project_id], player_id: params[:player_id], active: true)
  end

  def edit
  end

  def update
    respond_to do |format|
      if @project_membership.update(project_membership_params)
        format.html { redirect_to @project_membership, notice: 'Project membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_membership }
      else
        format.html { render :edit }
        format.json { render json: @project_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project_membership.destroy
    respond_to do |format|
      format.html { redirect_to project_memberships_url, notice: 'Project membership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_project_membership
      @project_membership = ProjectMembership.find(params[:id])
    end

    def project_membership_params
      params.require(:project_membership).permit(:project_id, :player_id, :active, :owner)
    end
end
