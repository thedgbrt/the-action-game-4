class AddPreferencesToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :preferences, :text
  end
end
