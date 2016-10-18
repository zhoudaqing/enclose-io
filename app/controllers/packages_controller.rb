class PackagesController < ApplicationController
  before_action :authenticate_user!, only: [:update]

  def create
    @project = Project.find(params[:project_id])
    @project.check
    redirect_to @project, notice: 'Releases was successfully checked.'
  end
  
  def index
    @project = Project.find(params[:project_id])
    render json: @project.packages
  end
  
  def update
    begin
      raise 'Admin Only!' unless current_user.admin?
      @project = Project.find(params[:project_id])
      @package = @project.packages.find(params[:id])
      if @package.update(package_params)
        render json: @package
      else
        render json: @package.errors, status: :unprocessable_entity
      end
    rescue => e
      render json: e.message.to_json, status: :unprocessable_entity
    end
  end
  
  private
  def package_params
    params.require(:package).permit(:phase, :size, :url, :done_at)
  end
end
