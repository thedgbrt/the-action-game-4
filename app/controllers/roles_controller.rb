class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  before_action :set_team, except: [:show, :edit, :update, :destroy]

  def index
    @roles = params[:team_id] ? Team.find_by_id(params[:team_id]).roles : current_player.roles
  end

  def show
  end

  def new
    @role = Role.new
  end

  def edit
  end

  def create
    @role = Role.new(role_params)
    if @role.short.nil? || @role.short == ''
      @role.short = @role.name
    end

    @role.team_id = params[:team_id] unless @role.team_id

    if @role.save
      RoleAssignment.create!(role_id: @role.id, player_id: current_player.id)
      render json: @role
    else
      render json: @role.errors, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to roles_path, notice: 'Role was successfully updated.' }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url, notice: 'Role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_role
      @role = Role.find(params[:id])
    end

    def set_team
      @team = Team.find_by_id(params[:team_id])
    end

    def role_params
      params.require(:role).permit(:name, :team_id, :url, :description, :parent_id, :short, :external_id)
    end
end
