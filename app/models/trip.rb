class Trip < ApplicationRecord
  validates_presence_of :destination
  belongs_to :user
end
