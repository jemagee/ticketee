require 'rails_helper'

RSpec.feature "Editing Tickets" do

	let!(:project) { FactoryGirl.create(:project, name: "NBA.com") }
	let!(:user) { FactoryGirl.create(:user) }
	let!(:ticket) { FactoryGirl.create(:ticket, project: project, title: "The PBP Project", author: user)}

	before do
		visit root_path
		click_link project.name
		click_link ticket.title
		click_link "Edit Ticket"
	end

	scenario "WIth Proper information" do
		fill_in "Title", with: "Getting play by play"
		fill_in "Description", with: "Gotta parse the JSON Properly"
		click_button "Update Ticket"
		expect(page).to have_content("Ticket updated!")
		expect(page).to have_content("Getting play by play")
		expect(page).to_not have_content("The PBP Project")
	end

	scenario "with invalid information" do
		fill_in "Title", with: ""
		fill_in "Description", with: ""
		click_button "Update Ticket"
		expect(page).to have_content("Ticket update failed")
		expect(page).to have_content("Title can't be blank")
		expect(page).to have_content("Description can't be blank")
		expect(page).to_not have_link(project.name)
	end
end