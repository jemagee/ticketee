class ProjectsController < ApplicationController
	before_action :find_project, only: [:show, :edit, :update, :destroy]
	def index
		@projects = Project.all
	end

	def new
		@project = Project.new
	end

	def show
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
	end

	def update
		if @project.update(project_params)
			flash[:success] = "Project successfully updated"
			redirect_to @project
		else
			flash.now[:alert] = "Project update failed"
			render 'edit'
		end
	end

	def destroy
		@project.destroy
		flash[:notice] = "Project has been deleted"
		redirect_to root_path
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
end
