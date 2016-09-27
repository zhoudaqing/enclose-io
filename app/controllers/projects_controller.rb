class ProjectsController < ApplicationController
  def index
    if params[:mine]
      @projects = current_user.projects
    else
      @projects = Project.hot
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    params[:project][:name].strip!
    @project = Project.find_or_create_by(name: params[:project][:name])
    render :new and return unless @project.valid?
    @project.project_users.find_or_create_by(user_id: current_user.id)
    redirect_to @project, notice: 'Project was successfully created.'
  end

  def destroy
    @project = Project.find(params[:id])
    project_user = @project.project_users.find_by(user_id: current_user.id)
    if project_user
      project_user.destroy
      redirect_to projects_url(mine: true), notice: 'Project was successfully destroyed.'
    else
      redirect_to projects_url(mine: true), alert: 'Project cannot be found.'
    end
  end
end
