# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
unless User.exists?(email: "admin@ticketee.com")
	User.create!(email: "admin@ticketee.com", password: "password", admin: true)
end
unless User.exists?(email: "viewer@ticketee.com")
	User.create!(email: "viewer@ticketee.com", password: "password")
end
unless Project.exists?(name: "Sublime Text 3")
	Project.create!(name: "Sublime Text 3", description: "A sample project about Sublime Text 3")
end
unless Project.exists?(name: "Internet Explorer")
	Project.create!(name: "Internet Explorer", description: "A sample project about Internet Explorer")
end
