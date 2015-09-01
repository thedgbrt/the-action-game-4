class AddExternalIdToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :external_id, :integer
  end
end
