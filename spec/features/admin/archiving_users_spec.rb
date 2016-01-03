require 'rails_helper'

RSpec.feature "Archiving users as an admin" do

  let(:admin) {FactoryGirl.create(:user, :admin)}
  let(:user) {FactoryGirl.create(:user)}

  before do
    login_as(admin)
  end

  scenario "Successfully archiving a user" do
    visit admin_user_path(user)
    click_link "Archive User"

    expect(page).to have_content "User has been archived!"
    expect(page).to_not have_content user.email
  end

  scenario "Trying to archive yourself" do
    visit admin_user_path(admin)
    click_link "Archive User"
    expect(page).to have_content "You can not archive yourself!"
    expect(page).to have_content(admin.email)
  end

end