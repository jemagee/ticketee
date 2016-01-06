require 'rails_helper'

RSpec.feature "Users can View Projects" do

  let(:user) {FactoryGirl.create(:user)}
  let(:project) {FactoryGirl.create(:project, name: "Sublime Text 3")}

  before do
    login_as(user)
    assign_role!(user, :viewer, project)
  end

	scenario "Listing all projects" do
		visit "/"
		click_link "Sublime Text 3"
		expect(page.current_url).to eql(project_url(project))
	end

  scenario "Unless they do not have the permission" do
    FactoryGirl.create(:project, name: "Hidden")
    visit "/"
    expect(page).not_to have_content "Hidden"
  end
end