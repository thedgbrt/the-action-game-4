class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_team, except: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
    @project.active = true
    @project.commitment = true
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    @project.team_id = params[:team_id] unless @project.team_id
    @project.active = params[:active] if @project.active.nil?
    @project.commitment = params[:commitment] if @project.commitment.nil?

    if @project.save
      render json: @project
      if @project.creator_id
        ProjectMembership.create!(project_id: @project.id, player_id: @project.creator_id, active: true)
      end
    else
      render json: @project.errors, status: :unprocessable_entity
    end
    #
    # respond_to do |format|
    #   if @project.save
    #     format.html { redirect_to @project.team || projects_path, notice: 'Project was successfully created.' }
    #     format.json { render :show, status: :created, location: @project }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @project.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project.team || projects_path, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def set_team
      @team = Team.find_by_id(params[:team_id])
    end

    def project_params
      params.require(:project).permit(:name, :team_id, :active, :commitment, :visible_to, :ancestry,
        :description, :parent_id, :creator_id)
    end
end
