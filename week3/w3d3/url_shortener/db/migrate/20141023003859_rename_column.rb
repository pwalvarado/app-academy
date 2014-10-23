class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :taggings, :tagged_topic_id, :tag_topic_id
  end
end
