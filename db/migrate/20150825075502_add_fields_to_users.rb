class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :fictional, :boolean, default: false
    add_column :users, :current_time_zone, :string, default: 'Pacific Time (US & Canada)'
  end
end
