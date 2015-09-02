class AddPlanningFieldsToAktions < ActiveRecord::Migration
  def up
    add_column :aktions, :planned, :boolean, default: false
    add_column :aktions, :planned_date, :date
    add_column :aktions, :planned_sequence_number, :integer
  end

  def down    
  end
end
