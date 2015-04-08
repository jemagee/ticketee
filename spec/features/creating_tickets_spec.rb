require 'rails_helper'

RSpec.feature "Creating Tickets" do

	before do
		FactoryGirl.create(:project, name: "NBA.com Project")
		visit "/"
		click_link "NBA.com Project"
		click_link "New Ticket"
	end

	scenario "with valid attribtues" do

		fill_in "Title", with: "Finding JSON links"
		fill_in "Description", with: "Need to isolated all raw data"
		click_button "Create Ticket"
		expect(page).to have_content("Ticket has been created")
		expect(page).to have_content("Finding JSON links")
		expect(page).to have_content("NBA.com Project")
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
