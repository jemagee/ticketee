require 'rails_helper'

RSpec.feature "Creating Projects" do

	before do
		visit "/"
		click_link "New Project"
	end

	scenario "A user can create a new project" do
		fill_in "Project Name", with: "Sublime Text 3"
		fill_in "Description", with: "A text editor for everyone"
		click_button "Create Project"
		project = Project.first
		expect(page).to have_content("Project has been created.")
		expect(page).to have_title("Sublime Text 3 - Projects - Ticketee")
		expect(page.current_url).to eql(project_url(project))	
	end

	scenario "A project without a name is rejected" do
		click_button "Create Project"
		expect(page).to have_content("Project has not been created")
		expect(page).to have_content("Name can't be blank")
	end

	scenario "A project must be at least 5 characters" do
		fill_in "Project Name", with: "1234"
		click_button "Create Project"
		expect(page).to have_content("Project has not been created")
		expect(page).to have_content("Name is too short")
	end
end
