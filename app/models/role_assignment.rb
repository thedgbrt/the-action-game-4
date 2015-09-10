class RoleAssignment < ActiveRecord::Base
  belongs_to :role
  belongs_to :player

  validates_uniqueness_of :player_id, :scope => [:role_id], :message => "This role assignment already exists."
end
