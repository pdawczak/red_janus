class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, null: false, limit: 10
    add_index :users, :username, unique: true
  end
end
