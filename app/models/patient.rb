class Patient < ApplicationRecord
  validates :first_name, :last_name, :contact, :age, :problem, presence: true
end
