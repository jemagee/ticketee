require 'rails_helper'

RSpec.feature "Viewing Tickets (through projects)" do

	before do
		user = FactoryGirl.create(:user)
		sublime = FactoryGirl.create(:project, name:"Sublime Text 3")
		FactoryGirl.create(:ticket, project: sublime, title: "Make it shiny", description: "Gradients, Starbursts, Oh MY!", author: user)
		nba = FactoryGirl.create(:project, name: "NBA.com data scrape")
		FactoryGirl.create(:ticket, project: nba, title: "Get JSON", description: "Hard pain in the arse to find", author: user)
		visit "/"
	end

	scenario "For a given project" do
		click_link "Sublime Text 3"
		expect(page).to have_content("Make it shiny")
		expect(page).to_not have_content("Get JSON")
		click_link "Make it shiny" 
			within("#ticket h2") do
				expect(page).to have_content("Make it shiny")
			end
		expect(page).to have_content("Gradients,")
	end
end	