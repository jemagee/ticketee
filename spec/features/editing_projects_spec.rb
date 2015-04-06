require 'rails_helper'

RSpec.feature "Editing/Updating Projects" do

	before do
		FactoryGirl.create(:project)
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
