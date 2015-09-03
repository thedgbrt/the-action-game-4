class RoleAssignmentsController < ApplicationController
  before_action :set_role_assignment, only: [:destroy]

  def index
    @role_assignments = RoleAssignment.all
  end

  def new
    RoleAssignment.create!(role_id: params[:role_id], player_id: params[:player_id])
    redirect_to back_or_home
  end

  def destroy
    @role_assignment = RoleAssignment.find(params[:id])
    @role_assignment.destroy
    respond_to do |format|
      format.html { redirect_to back_or_home, notice: 'Role assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def role_assignment_params
      params.require(:role_assignment).permit(:role_id, :player_id, :active, :primary)
    end
end
