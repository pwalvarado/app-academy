class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :album_id
      t.string :name
      t.string :ttype
      t.text :lyrics

      t.timestamps
    end
    add_index :tracks, :album_id
    add_index :tracks, :name
    add_index :tracks, :ttype
  end
end
