class User < ApplicationRecord
  # encrypt password
  has_secure_password
  
  before_destroy :destroy_trips


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
   # @trips = self.trips.where('extract(month from start_date) = ?', month).order(:start_date)
    @trips = self.trips.where(:start_date => DateTime.now..DateTime.now + 30).order(:start_date)
  end
  
  private

   def destroy_trips
     self.trips.destroy_all   
   end
  
end
