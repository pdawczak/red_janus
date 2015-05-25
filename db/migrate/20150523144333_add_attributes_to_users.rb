class AddAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :title,        :string, null: false, limit: 8
    add_column :users, :first_names,  :string, null: false
    add_column :users, :middle_names, :string
    add_column :users, :last_names,   :string, null: false
    add_column :users, :dob,          :date,   null: false
  end
end
