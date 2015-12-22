class CreateCitations < ActiveRecord::Migration

  def up
    create_table :citations do |t|
      t.integer :origin_id
      t.integer :target_id
      t.string :content
      t.timestamps null:false
    end
    add_foreign_key :citations, :articles, column: :origin_id
    add_foreign_key :citations, :articles, column: :target_id
  end

  def down
    drop_table :citations
  end

end
