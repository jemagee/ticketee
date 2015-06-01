require 'rails_helper'

RSpec.feature "Creating Projects" do

	before do
		login_as(FactoryGirl.create(:user, :admin))
		visit "/"
		click_link "New Project"
	end

	scenario "A user can create a new project" do
		fill_in "Name", with: "Sublime Text 3"
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
		fill_in "Name", with: "1234"
		click_button "Create Project"
		expect(page).to have_content("Project has not been created")
		expect(page).to have_content("Name is too short")
	end

	scenario "A project must have a description" do
		fill_in "Name", with: "New Project"
		click_button "Create Project"
		expect(page).to have_content("Project has not been created")
		expect(page).to have_content("Description can't be blank")
	end

	scenario "A project description must be at least 10 characters" do
		fill_in "Name", with: "New Project"
		fill_in "Description", with: "123456789"
		click_button "Create Project"
		expect(page).to have_content("Project has not been created")
		expect(page).to have_content("Description is too short")
	end
end
