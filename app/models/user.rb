class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tickets, foreign_key: "author_id"

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end
end
