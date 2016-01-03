class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :excluding_archived, lambda { where(archived_at: nil)}

  has_many :tickets, foreign_key: "author_id"

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end

  def archive
    update(archived_at: Time.now)
  end
end
