require 'rails_helper'

RSpec.feature "Creating Tickets" do

	let!(:user) { FactoryGirl.create(:user)}

	before do
		login_as(user)
		project = FactoryGirl.create(:project, name: "NBA.com Project")
		assign_role!(user, :viewer, project)
		visit "/"
		click_link "NBA.com Project"
		click_link "New Ticket"
	end

	scenario "with valid attributes" do

		fill_in "Title", with: "Finding JSON links"
		fill_in "Description", with: "Need to isolated all raw data"
		click_button "Create Ticket"
		expect(page).to have_content("Ticket has been created")
		expect(page).to have_content("Finding JSON links")
		expect(page).to have_content("NBA.com Project")
		within("#ticket #author") do
			expect(page).to have_content("Created by #{user.email}")
		end
	end

	scenario "with missing fields" do

		click_button "Create Ticket"
		
		expect(page).to have_content("Title can't be blank")
		expect(page).to have_content("Description can't be blank")
		expect(page).to have_content("Ticket has not been created")
	end

	scenario "with an invalid description" do
		fill_in "Title", with: "Finding JSON links"
		fill_in "Description", with: "a" * 9
		click_button "Create Ticket"
		expect(page).to_not have_content("Finding JSON links")
		expect(page).to have_content("Description is too short")
	end
end
