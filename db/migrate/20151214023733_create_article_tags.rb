class CreateArticleTags < ActiveRecord::Migration

  def up
    create_table :article_tags do |t|
      t.integer :article_id, null:false
      t.integer :tag_id, null:false
    end
    add_foreign_key :article_tags, :articles
    add_foreign_key :article_tags, :tags
    add_index :article_tags, [:article_id, :tag_id], unique:true
  end

  def down
    drop_table :article_tags
  end
end
