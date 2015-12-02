class MakeReferencesPolymorphic < ActiveRecord::Migration

  def up
    execute "CREATE TYPE referenceable_type_enum AS ENUM ('Note', 'Relation')"
    remove_foreign_key :references, :notes
    rename_column :references, :note_id, :referenceable_id
    add_column :references, :referenceable_type, :referenceable_type_enum, null:false
    add_index :references, [:referenceable_id, :referenceable_type]
  end

  def down
    remove_index :references, [:referenceable_id, :referenceable_type]
    remove_column :references, :referenceable_type
    execute "DROP TYPE referenceable_type_enum"
    rename_column :references, :referenceable_id, :note_id
    add_foreign_key :references, :notes
  end

  #  create_table :taggings do |t|
  #    t.integer :tag_id, null:false
  #    t.integer :tagable_id, null:false
  #    t.column :tagable_type, :tagable_type_enum, null:false
  #    #t.belongs_to :tagable, polymorphic:true
  #  end
  #  #add_foreign_key :taggings, :notes
  #  add_foreign_key :taggings, :tags
  #  add_index :taggings, [:tagable_id, :tagable_type]

end
