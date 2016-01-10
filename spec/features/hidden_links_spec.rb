require 'rails_helper'

RSpec.feature 'hidden links' do
  let(:user) { FactoryGirl.create(:user)}
  let(:admin) { FactoryGirl.create(:user, :admin)}
  let(:project) { FactoryGirl.create(:project)}


  context "anonymous users" do
  	scenario "cannot see the New Project link" do
  		visit "/"
  		expect(page).not_to have_link "New Project"
  	end
  end

  context "regular users" do
    before do
      assign_role!(user, :viewer, project)
      login_as(user)
    end

  	scenario "cannot see the New Project link" do
  		visit "/"
  		expect(page).not_to have_link "New Project"
  	end
    scenario "cannot see the Delete Link on Project Page" do
      visit project_path(project)
      expect(page).not_to have_link "Delete Project"
    end
    scenario "cannot see the Edit Link on Project Page" do
      visit project_path(project)
      expect(page).not_to have_link "Edit Project"
    end
    scenario "Can not see the new ticket link on Project Page" do
      visit project_path(project)
      expect(page).not_to have_link "New Ticket"
    end
  end

  context "admin users" do
  	before { login_as(admin) }
  	scenario "can see the new project link" do
  		visit "/"
  		expect(page).to have_link "New Project"
  	end
    scenario "can see the Delete  Link on Project Page" do
      visit project_path(project)
      expect(page).to have_link "Delete Project"
    end
    scenario "can see the Edit Link on Project Page" do
      visit project_path(project)
      expect(page).to have_link "Edit Project"
    end
    scenario "can see the New Ticket Link" do
      visit project_path(project)
      expect(page).to have_link "New Ticket"
    end
  end

  context "manager user" do

    before do
      assign_role!(user, :manager, project)
      login_as(user)
    end
    
    scenario "cannot see the New Project link" do
      visit "/"
      expect(page).not_to have_link "New Project"
    end
    scenario "cannot see the Delete Link on Project Page" do
      visit project_path(project)
      expect(page).not_to have_link "Delete Project"
    end
    scenario "can see the Edit Link on Project Page" do
      visit project_path(project)
      expect(page).to have_link "Edit Project"
    end
    scenario "can see the New Ticket Link on Project Page" do
      visit project_path(project)
      expect(page).to have_link "New Ticket"
    end
  end


end