class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, null: false
  end
  add_index(:user, :username, unique: true)
end
