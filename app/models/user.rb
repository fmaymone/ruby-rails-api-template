class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :trips
  has_many :assignments
  has_many :roles, through: :assignments
  # Validations
  validates_presence_of :name, :email, :password_digest
  
  def role?(role, entity_id = nil)
    if entity_id.present?
      roles.where(entity_id: entity_id, name: role).any?
    else
      logger.warn "Role check used without an entity id presented"
      #{role} called for #{id} user"
      roles.any? {|r| r.name.to_sym == role}
    end
  end
end
