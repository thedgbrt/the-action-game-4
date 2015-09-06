class AddColorToTeamMemberships < ActiveRecord::Migration
  def change
    add_column :team_memberships, :color, :string
  end
end
