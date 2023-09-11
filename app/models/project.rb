class Project < ApplicationRecord
    # validates :projectname, presence :true
    has_many :tasks
    has_many :users, through: :tasks
end
