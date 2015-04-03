require 'rails_helper'

RSpec.feature "Creating Projects" do
	scenario "A user can create a new project" do
		visit "/"
		click_link "New Project"
		fill_in "Project Name", with: "Sublime Text 3"
		fill_in "Description", with: "A text editor for everyone"
		click_button "Create Project"
		project = Project.first
		expect(page).to have_content("Project has been created.")
		expect(page).to have_title("Sublime Text 3 - Projects - Ticketee")
		expect(page.current_url).to eql(project_url(project))
		
	end
end
