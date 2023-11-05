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
end
