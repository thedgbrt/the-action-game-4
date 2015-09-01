class AddApiKeyToTeamMemberships < ActiveRecord::Migration
  def change
    add_column :team_memberships, :api_key, :string
  end
end
