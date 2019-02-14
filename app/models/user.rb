class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :trips
  has_many :assignments
    # Validations
  validates_presence_of :name, :email, :password_digest
  
  enum role: [:regular, :manager, :admin]
  
  after_initialize do
    if self.new_record?
      self.role ||= :regular
    end
  end
  
end
