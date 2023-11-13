class User <ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :api_key, uniqueness: true, presence: true
  validates_presence_of :name, :password, :password_confirmation

  has_secure_password
end