class Task < ApplicationRecord
    validates :submittedto,presence: true
    belongs_to :user
    belongs_to :project

  # Set the default value for 'completed' attribute
  attribute :completed, :boolean, default: false

  # Validate that 'completed' is either true or false
  validates :completed, inclusion: { in: [true, false] }

  
end
