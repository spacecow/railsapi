class CreateArticleMentions < ActiveRecord::Migration

  def up
    create_table :article_mentions do |t|
      t.integer :origin_id, null:false
      t.integer :target_id, null:false
      t.string :content
    end
    add_foreign_key :article_mentions, :events, column: :origin_id
    add_foreign_key :article_mentions, :articles, column: :target_id
    add_index :article_mentions, [:origin_id, :target_id], unique:true
  end

  def down
    drop_table :article_mentions
  end

end
