class SessionTokenUniqueness < ActiveRecord::Migration
  def change
    remove_index :users, :session_token
    add_index :users, :session_token, :unique => true
  end
end
