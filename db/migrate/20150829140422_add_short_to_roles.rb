class AddShortToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :short, :string
  end
end
