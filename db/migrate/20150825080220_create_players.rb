class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :provider
      t.string :uid
      t.integer :role
      t.string :email
      t.boolean :fictional, default: false
      t.string :current_time_zone, default: 'Pacific Time (US & Canada)'

      t.timestamps null: false
    end
  end
end
