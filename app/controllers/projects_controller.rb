class ProjectsController < ApplicationController

	def index
		@projects = Project.all
	end

	def new
		@project = Project.new
	end

	def show
		find_project
	end

	def create
		@project = Project.new(project_params)
		if @project.save
			flash[:notice] = "Project has been created."
			redirect_to @project
		else
			flash.now[:error] = "Project has not been created"
			render 'new'
		end
	end

	def edit
		find_project
	end

	def update
		find_project

		if @project.update(project_params)
			flash[:success] = "Project successfully updated"
			redirect_to @project
		else
			flash.now[:alert] = "Project update failed"
			render 'edit'
		end
	end

	private 

		def project_params
			params.require(:project).permit(:name, :description)
		end

		def find_project
			@project = Project.find(params[:id])
		end
end
