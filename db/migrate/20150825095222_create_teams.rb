class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :creator_id
      t.string :name
      t.text :description
      t.string :url
      t.string :logo_url

      t.timestamps null: false
    end
  end
end
