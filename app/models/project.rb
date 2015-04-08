class Project < ActiveRecord::Base

	has_many :tickets
	
	validates :name, presence: true, length: {minimum: 5}
	validates :description, presence: true, length: {minimum: 10}
end
