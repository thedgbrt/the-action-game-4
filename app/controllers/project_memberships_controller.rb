class ProjectMembershipsController < ApplicationController
  before_action :set_project_membership, only: [:show, :edit, :update, :destroy]

  # GET /project_memberships
  # GET /project_memberships.json
  def index
    @project_memberships = ProjectMembership.all
  end

  # GET /project_memberships/1
  # GET /project_memberships/1.json
  def show
  end

  # GET /project_memberships/new
  def new
    @project_membership = ProjectMembership.new
  end

  # GET /project_memberships/1/edit
  def edit
  end

  # POST /project_memberships
  # POST /project_memberships.json
  def create
    @project_membership = ProjectMembership.new(project_membership_params)

    respond_to do |format|
      if @project_membership.save
        format.html { redirect_to @project_membership, notice: 'Project membership was successfully created.' }
        format.json { render :show, status: :created, location: @project_membership }
      else
        format.html { render :new }
        format.json { render json: @project_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_memberships/1
  # PATCH/PUT /project_memberships/1.json
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

  # DELETE /project_memberships/1
  # DELETE /project_memberships/1.json
  def destroy
    @project_membership.destroy
    respond_to do |format|
      format.html { redirect_to project_memberships_url, notice: 'Project membership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_membership
      @project_membership = ProjectMembership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_membership_params
      params.require(:project_membership).permit(:project_id, :player_id, :active, :owner)
    end
end
