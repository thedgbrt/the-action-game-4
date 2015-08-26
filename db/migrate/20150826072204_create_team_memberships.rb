class CreateTeamMemberships < ActiveRecord::Migration
  def change
    create_table :team_memberships do |t|
      t.integer :player_id
      t.integer :team_id
      t.boolean :active, default: true
      t.boolean :admin, default: false

      t.timestamps null: false
    end
  end
end
