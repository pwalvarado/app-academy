class AddRequesterIdToCatRequest < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :requester_id, :integer
    change_column :cat_rental_requests, :requester_id, :integer, null: false
  end
end
