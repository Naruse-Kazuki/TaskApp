class Task < ApplicationRecord
  belongs_to :user
  validates :note, length:{ maximum: 50 }
end
