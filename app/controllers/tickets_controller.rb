class TicketsController < ApplicationController

	before_action :get_project
	before_action :get_ticket, only: [:edit, :update, :show, :destroy]

	def new
		@ticket = @project.tickets.build
	end

	def create
		@ticket = @project.tickets.build(private_params)
		if @ticket.save
			flash[:success] = "Ticket has been created"
			redirect_to [@project, @ticket]
		else
			flash.now[:warning] = "Ticket has not been created"
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update
		if @ticket.update(private_params)
			flash[:success] = "Ticket updated!"
			redirect_to @project
		else
			flash[:warning] = "Ticket update failed"
			render 'edit'
		end
	end

	def destroy
		@ticket.destroy
		flash[:success] = "Ticket Deleted"
		redirect_to @project
	end

	private

		def get_project
			@project = Project.find(params[:project_id])
		end

		def private_params
			params.require(:ticket).permit(:title, :description)
		end

		def get_ticket
			@ticket = @project.tickets.find(params[:id])
		end
end
