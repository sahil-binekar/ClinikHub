class User < ApplicationRecord
  has_secure_password

  # enum :role, { doctor: "doctor", receptionist: "receptionist" }
  # enum :role, { doctor: 0, receptionist: 1 }
  enum :role, [:Doctor, :Receptionist]

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
