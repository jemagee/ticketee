require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
	it "displays an error for a missing project" do
		get :show, id: "not-here"
		expect(response).to redirect_to(root_path)
		expect(flash[:alert]).to eql("The project you were looking for could not be found")
	end
end
