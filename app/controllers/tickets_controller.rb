class TicketsController < ApplicationController

	before_action :get_project
	before_action :get_ticket, only: [:edit, :update, :show, :destroy]
	before_action :authorize_change, only: [:edit, :update]

	def new
		@ticket = @project.tickets.build
	end

	def create
		@ticket = @project.tickets.build(private_params)
		@ticket.author = current_user
		authorize @ticket, :create?
		if @ticket.save
			flash[:success] = "Ticket has been created"
			redirect_to [@project, @ticket]
		else
			flash.now[:warning] = "Ticket has not been created"
			render 'new'
		end
	end

	def show
		authorize @ticket, :show?
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
		authorize @ticket, :destroy?
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

		def authorize_change
			authorize @ticket, :update?
		end
end
