class AddShortToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :short, :string
  end
end
