class ProjectsController < ApplicationController

  before_action :find_project, only: %i[edit update destroy]

  def index
    @public_projects = Project.public_type
    @private_projects = current_user.projects.private_type if user_signed_in?
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.create(project_params)

    if @project.persisted?
      flash[:success] = 'Project has been successfully created'
      redirect_to root_path
    else
      flash[:error] = @project.errors.full_messages.to_sentence
      redirect_to new_project_path
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      flash[:success] = 'Project has been successfully updated'
      redirect_to root_path
    else
      flash[:error] = @project.errors.full_messages.to_sentence
      redirect_to edit_project_path(@project)
    end
  end

  def destroy
    @project.destroy
    flash[:success] = 'Project has been successfully deleted'
    redirect_to root_path
  end

  private

  def project_params
    params.require(:project).permit(:logo, :name, :project_type, :description)
  end

  def find_project
    @project = Project.find(params[:id])
  end

end