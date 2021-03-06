require 'rails_helper'

RSpec.feature "Users can sign up" do

	scenario "With valid Details" do

		visit root_path
		click_link "Sign up"
		fill_in "Email", with: "example@example.com"
		fill_in "user_password", with: "password"
		fill_in "Password confirmation", with: "password"
		click_button "Sign up"
		expect(page).to have_content("You have signed up successfully")
	end
end