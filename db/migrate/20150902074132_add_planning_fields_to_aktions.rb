class AddPlanningFieldsToAktions < ActiveRecord::Migration
  def change
    add_column :aktions, :planned, :boolean, default: false
    add_column :aktions, :planned_date, :date
    add_column :aktions, :planned_sequence_number, :integer
  end
end
