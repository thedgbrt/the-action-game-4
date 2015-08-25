class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.integer :team_id
      t.string :url

      t.timestamps null: false
    end
  end
end
