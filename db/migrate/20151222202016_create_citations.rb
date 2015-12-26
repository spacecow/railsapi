class CreateCitations < ActiveRecord::Migration

  def up
    create_table :citations do |t|
      t.integer :origin_id
      t.integer :target_id
      t.string :content, null:false
      t.timestamps null:false
    end
    execute "ALTER TABLE citations ADD CONSTRAINT content_cannot_be_blank " +
      "CHECK (char_length(content) <> 0)"
    execute "ALTER TABLE citations ADD CONSTRAINT " +
      "both_origin_id_and_target_id_cannot_be_nil " +
      "CHECK (origin_id is NOT NULL OR target_id is NOT NULL)"
    add_foreign_key :citations, :articles, column: :origin_id
    add_foreign_key :citations, :articles, column: :target_id
  end

  def down
    drop_table :citations
  end

end
