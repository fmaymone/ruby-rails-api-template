class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :trips
  has_many :assignments
    # Validations
  validates_presence_of :name, :email, :password_digest
  validates :email, :uniqueness => { :case_sensitive => false }
  
  enum role: [:regular, :manager, :admin]
  
  after_initialize do
    if self.new_record?
      self.role ||= :regular
    end
  end
  
  def trips_for_month(month)
    @trips = self.trips.where(:start_date => DateTime.now..DateTime.now + 30).order(:start_date)
  end
  
end
