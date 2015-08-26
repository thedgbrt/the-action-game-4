class CreateRoleAssignments < ActiveRecord::Migration
  def change
    create_table :role_assignments do |t|
      t.integer :role_id
      t.integer :player_id
      t.boolean :active, default: true
      t.boolean :primary

      t.timestamps null: false
    end
  end
end
