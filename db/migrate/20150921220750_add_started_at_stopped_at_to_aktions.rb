class AddStartedAtStoppedAtToAktions < ActiveRecord::Migration
  def change
    add_column :aktions, :started_at, :datetime
    add_column :aktions, :stopped_at, :datetime
  end
end
