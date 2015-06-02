require 'rails_helper'

RSpec.feature "Deleting Projects" do

	before do
		login_as(FactoryGirl.create(:user, :admin))
		FactoryGirl.create(:project)
		visit "/"
		click_link "Sublime Text 3"
		login_as(FactoryGirl.create(:user, :admin))
	end

	scenario "Deleting a post" do
		click_link "Delete Project"
		expect(page).to_not have_content("Sublime Text 3")
		expect(page).to have_content("Project has been deleted")
		expect(page.current_url).to eql(root_url)
	end

end
