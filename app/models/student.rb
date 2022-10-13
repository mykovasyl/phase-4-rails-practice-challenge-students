class Student < ApplicationRecord
  belongs_to :instructor

  validates :name, presence: true
  validates :age, exclusion: { in: 0..17, message: "Must be 18 years or older." }
  validates :instructor_id, presence: true
end
