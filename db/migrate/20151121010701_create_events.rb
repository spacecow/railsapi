class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.integer :universe_id, null:false
      t.string :title, null:false
      t.timestamps null:false
    end
    execute "ALTER TABLE events ADD CONSTRAINT title_cannot_be_blank CHECK (char_length(title) <> 0)"
    #TODO add_index :books, [:title, :universe_id], unique:true
    add_foreign_key :events, :universes
  end

  def down
    drop_table :events
  end
end
