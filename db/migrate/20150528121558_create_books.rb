class CreateBooks < ActiveRecord::Migration
  def up
    create_table :books do |t|
      t.string :title, null:false
      t.integer :universe_id, null:false
    end
    execute "ALTER TABLE books ADD CONSTRAINT title_cannot_be_blank CHECK (char_length(title) <> 0)"
    add_index :books, [:title, :universe_id], unique:true
    add_foreign_key :books, :universes
  end

  def down
    drop_table :books
  end
end
