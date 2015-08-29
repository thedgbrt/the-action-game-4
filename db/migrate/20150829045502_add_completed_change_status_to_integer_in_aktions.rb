class AddCompletedChangeStatusToIntegerInAktions < ActiveRecord::Migration
  def change
    add_column :aktions, :completed, :boolean, default: false
    change_column :aktions, :status, 'integer USING CAST(status AS integer)'
  end
end
