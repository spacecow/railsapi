class CreateUniverses < ActiveRecord::Migration
  def up
    create_table :universes do |t|
      t.string :title, null:false
    end
    execute "ALTER TABLE universes ADD CONSTRAINT title_cannot_be_blank CHECK (char_length(title) <> 0)"
    add_index :universes, :title, unique:true
  end

  def down
    drop_table :universes
  end
end
