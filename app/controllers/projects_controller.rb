class ProjectsController < ApplicationController
	before_action :find_project, only: [:show, :edit, :update]
	before_action :authorize_project_edit, only: [:edit, :update]

	def index
		@projects = policy_scope(Project)
	end

	def show
		authorize @project, :show?
	end

	def edit
	end

	def update
		if @project.update(project_params)
			flash[:success] = "Project successfully updated"
			redirect_to @project
		else
			flash.now[:warning] = "Project update failed"
			render 'edit'
		end
	end

	private 

		def project_params
			params.require(:project).permit(:name, :description)
		end

		def find_project
			@project = Project.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			flash[:alert] = "The project you were looking for could not be found"
			redirect_to root_path
		end

		def authorize_project_edit
			authorize @project, :update?
		end
end
