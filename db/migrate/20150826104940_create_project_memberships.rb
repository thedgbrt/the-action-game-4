class CreateProjectMemberships < ActiveRecord::Migration
  def change
    create_table :project_memberships do |t|
      t.integer :project_id
      t.integer :player_id
      t.boolean :active, default: true
      t.boolean :owner

      t.timestamps null: false
    end
  end
end
