class Task < ApplicationRecord
  belongs_to :user
  validates :task_name, presence: true, length:{ maximum: 50 }
  validates :note, presence: true, length:{ maximum: 500 }
end
