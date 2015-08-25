class CreateAktions < ActiveRecord::Migration
  def change
    create_table :aktions do |t|
      t.datetime :timeslot
      t.string :focus
      t.integer :player_id
      t.integer :verb_id
      t.integer :project_id
      t.integer :flow
      t.text :flow_notes
      t.integer :value
      t.text :value_notes
      t.integer :visible_to
      t.string :status
      t.integer :intensity
      t.text :how_it_went
      t.string :time_zone
      t.integer :location_id
      t.integer :role_id
      t.text :properties

      t.timestamps null: false
    end
  end
end
