require 'rails_helper'

RSpec.feature "Deleting a ticket properly" do

	let!(:project) { FactoryGirl.create(:project) }
	let!(:user) { FactoryGirl.create(:user) }
	let!(:ticket) { FactoryGirl.create(:ticket, project: project, title: "Ticket 1", author: user)}
	let!(:ticket2) { FactoryGirl.create(:ticket, project: project, title: "Ticket 2", author: user)}

	before do
		visit root_path
		click_link project.name
	end

	scenario "Deleting a ticket on the project page" do
		within("#tickets p##{ticket.id}") do
			click_link "Delete Ticket"
		end
		expect(page).to have_content("Ticket Deleted")
		expect(page).to_not have_link(ticket.title)
		expect(page).to have_link(ticket2.title)
	end

	scenario "Delteing a ticket on the ticket page" do
		click_link ticket.title
		click_link "Delete Ticket"
		expect(page).to have_content("Ticket Deleted")
		expect(page).to_not have_link(ticket.title)
		expect(page).to have_link(ticket2.title)
	end
end