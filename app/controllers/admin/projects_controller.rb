class Admin::ProjectsController < Admin::BaseController
	def new
		@project = Project.new
	end

	def create
		@project = Project.new(project_params)
		if @project.save
			flash[:success] = "Project has been created."
			redirect_to @project
		else
			flash.now[:warning] = "Project has not been created"
			render 'new'
		end
	end

	def destroy
		@project = Project.find(params[:id])
		@project.destroy
		flash[:success] = "Project has been deleted"
		redirect_to root_path
	end

	private
		def project_params
			params.require(:project).permit(:name, :description)
		end
end
