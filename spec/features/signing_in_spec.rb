require 'rails_helper'

RSpec.feature "A user can sign in" do

	let!(:user) { FactoryGirl.create(:user) }

	scenario "With valid credentials" do

		visit "/"
		click_link "Sign in" 
		fill_in "Email", with: user.email
		fill_in "Password", with: "password"
		click_button "Sign in"
		expect(page).to have_content("Signed in as #{user.email}")
	end

	scenario "Unless that user is archived" do

		user.archive

		visit "/"
		click_link "Sign in"
		fill_in "Email", with: user.email
		fill_in "Password", with: user.password
		click_button "Sign in"

		expect(page).to have_content("Your account has been archived")
		expect(page).to_not have_content("Signed in as #{user.email}")
	end
end