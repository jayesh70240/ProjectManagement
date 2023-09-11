class Task < ApplicationRecord
    # validates :assignedto, presence: true
    # validates :submittedto,presence: true
    belongs_to :user
    belongs_to :project
end
