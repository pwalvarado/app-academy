class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :band_id
      t.string :name
      t.string :ttype

      t.timestamps
    end
    add_index :albums, :band_id
    add_index :albums, :name, unique: true
    add_index :albums, :ttype
  end
end
