class AddFirstTeamIdToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :first_team_id, :integer
  end
end
