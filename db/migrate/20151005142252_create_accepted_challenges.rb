class CreateAcceptedChallenges < ActiveRecord::Migration
  def change
    create_table :accepted_challenges do |t|
      t.integer :player_id
      t.integer :challenge_id
      t.boolean :active, default: true
      t.string :comments
      t.datetime :starting
      t.datetime :ending

      t.timestamps null: false
    end
  end
end
