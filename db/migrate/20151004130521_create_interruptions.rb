class CreateInterruptions < ActiveRecord::Migration
  def change
    create_table :interruptions do |t|
      t.boolean :internal
      t.boolean :recovered
      t.integer :aktion_id
      t.string :details

      t.timestamps null: false
    end
  end
end
