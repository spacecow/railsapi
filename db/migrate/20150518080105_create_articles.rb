class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles do |t|
      t.string :name, null:false
      t.integer :universe_id, null:false
      t.string :type, null:false
    end
    execute "ALTER TABLE articles ADD CONSTRAINT name_cannot_be_blank CHECK (char_length(name) <> 0)"
    execute "ALTER TABLE articles ADD CONSTRAINT type_cannot_be_blank CHECK (char_length(type) <> 0)"
    add_foreign_key :articles, :universes
  end

  def down
    drop_table :articles
  end
end
