class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.boolean :daily
      t.boolean :weekly
      t.integer :item_type
      t.integer :operation_type
      t.integer :greater_than
      t.integer :less_than
      t.boolean :available
      t.integer :creator_id

      t.timestamps null: false
    end
  end
end
