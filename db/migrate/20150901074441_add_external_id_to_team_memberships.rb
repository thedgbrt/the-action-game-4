class AddExternalIdToTeamMemberships < ActiveRecord::Migration
  def change
    add_column :team_memberships, :external_id, :integer
  end
end
