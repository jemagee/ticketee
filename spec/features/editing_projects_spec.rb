require 'rails_helper'

RSpec.feature "Project Manager can edit/update Projects" do
	let(:user) { FactoryGirl.create(:user)}
	let(:project) {FactoryGirl.create(:project)}

	before do
		assign_role!(user, :manager, project)
		login_as(user)
		visit "/"
		click_link "Sublime Text 3"
		click_link "Edit Project"
	end

	scenario "Correct Editing test" do
		fill_in "Name", with: "Sublime Text 3 beta"
		click_button "Update Project"
		expect(page).to have_content("Sublime Text 3 beta")
		expect(page).to have_content("Project successfully updated")
	end

	scenario "Updating with blank name" do
		fill_in "Name", with: ""
		click_button "Update Project"
		expect(page).to have_content("Project update failed")
		expect(page).to have_content("Name can't be blank")
	end
end
