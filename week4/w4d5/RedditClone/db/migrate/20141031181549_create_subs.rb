class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title
      t.text :description
      t.integer :moderator_id

      t.timestamps
    end
    add_index :subs, :title, unique: true
  end
end
