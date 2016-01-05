class Project < ActiveRecord::Base

	has_many :tickets, dependent: :delete_all
	has_many :roles, dependent: :delete_all
	has_many :users, through: :roles
	
	validates :name, presence: true, length: {minimum: 5}
	validates :description, presence: true, length: {minimum: 10}
end
