class AddCommentsToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :comments, :string
  end
end
