require 'rails_helper'

RSpec.feature "Viewing Projects" do
	scenario "Listing all projects" do
		project = FactoryGirl.create(:project)
		visit "/"
		click_link "Sublime Text 3"
		expect(page.current_url).to eql(project_url(project))
	end
end