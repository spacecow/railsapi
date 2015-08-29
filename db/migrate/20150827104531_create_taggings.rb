class CreateTaggings < ActiveRecord::Migration
  def up
    execute "CREATE TYPE tagable_type_enum AS ENUM ('Note')"
    create_table :taggings do |t|
      t.integer :tag_id, null:false
      t.integer :tagable_id, null:false
      t.column :tagable_type, :tagable_type_enum, null:false
      #t.belongs_to :tagable, polymorphic:true
    end
    #add_foreign_key :taggings, :notes
    add_foreign_key :taggings, :tags
    add_index :taggings, [:tagable_id, :tagable_type]
  end

  def down
    drop_table :taggings
    execute "DROP TYPE tagable_type_enum"
  end
end

