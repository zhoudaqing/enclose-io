class ExecutablesController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @project.check
    redirect_to @project, notice: 'Releases was successfully checked.'
  end
end
