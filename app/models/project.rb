class Project < ActiveRecord::Base

	has_many :tickets, dependent: :delete_all
	has_many :roles, dependent: :delete_all
	has_many :users, through: :roles
	
	validates :name, presence: true, length: {minimum: 5}
	validates :description, presence: true, length: {minimum: 10}

  def has_member?(user)
    roles.exists?(user_id: user)
  end

  [:editor, :manager, :viewer].each do |role|
    define_method "has_#{role}?" do |user|
      roles.exists?(user_id: user, role: role)
    end
  end
end
