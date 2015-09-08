class AddDefaultColorToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :default_color, :string, default: '#FFFFFF'
  end
end
