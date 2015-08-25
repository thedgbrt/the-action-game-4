class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :team_id
      t.boolean :active
      t.boolean :commitment
      t.integer :visible_to
      t.string :ancestry

      t.timestamps null: false
    end
  end
end
