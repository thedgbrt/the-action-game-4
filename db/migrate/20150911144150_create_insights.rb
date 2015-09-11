class CreateInsights < ActiveRecord::Migration
  def change
    create_table :insights do |t|
      t.string :text
      t.string :category
      t.integer :player_id
      t.integer :aktion_id

      t.timestamps null: false
    end
  end
end
