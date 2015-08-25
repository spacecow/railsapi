class CreateTags < ActiveRecord::Migration

  def up
    execute "CREATE TYPE tagable_type_enum AS ENUM ('Note')"
    create_table :tags do |t|
      t.string :title, null:false
      #t.belongs_to :tagable, polymorphic:true
      t.integer :tagable_id, null:false
      t.column :tagable_type, :tagable_type_enum, null:false
    end
    #add_foreign_key :tags, :notes
    #execute "ALTER TABLE tags ADD CONSTRAINT tagable_type_cannot_be_blank CHECK (char_length(tagable_type) <> 0)"
    execute "ALTER TABLE tags ADD CONSTRAINT title_cannot_be_blank CHECK (char_length(title) <> 0)"
    add_index :tags, [:tagable_id, :tagable_type]
  end

  def down
    drop_table :tags
    execute "DROP TYPE tagable_type_enum"
  end

end
