class AddTeamIdToAktions < ActiveRecord::Migration
  def change
    add_column :aktions, :team_id, :integer
  end
end
