class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
  #  active admin
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "username","encrypted_password", "id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
  
end
