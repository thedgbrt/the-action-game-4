class CreateVerbs < ActiveRecord::Migration
  def change
    create_table :verbs do |t|
      t.string :name
      t.string :description
      t.integer :intensity
      t.integer :creator_id
      t.string :examples
      t.integer :level

      t.timestamps null: false
    end
  end
end
