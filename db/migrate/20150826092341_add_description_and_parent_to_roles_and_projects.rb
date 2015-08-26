class AddDescriptionAndParentToRolesAndProjects < ActiveRecord::Migration
  def change
    add_column :roles, :description, :text
    add_column :roles, :parent_id, :integer
    add_column :projects, :description, :text
    add_column :projects, :parent_id, :integer
  end
end
