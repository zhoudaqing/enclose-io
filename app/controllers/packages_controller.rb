class PackagesController < ApplicationController
  auth_opts = {
    name: ENV['ENCLOSE_IO_AUTH_NAME'],
    password: ENV['ENCLOSE_IO_AUTH_SECRET'],
    only: :update
  }
  http_basic_authenticate_with auth_opts
  skip_before_action :verify_authenticity_token, only: :update

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
