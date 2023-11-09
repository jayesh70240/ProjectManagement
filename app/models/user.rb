class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks
  has_many :projects, through: :tasks

  enum role: [:user, :manager]

  # add default role when newly user created!
  before_save do
    self.role = :user unless ['manager'].include?(self.role)
  end

  # display the user in the new task
  def full_name_with_role
    "#{username} (#{role})"
  end

  # active admin
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email","username", "role", "encrypted_password", "id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["projects", "tasks"]
  end

end
