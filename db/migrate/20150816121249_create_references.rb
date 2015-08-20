class CreateReferences < ActiveRecord::Migration

  def up
    create_table :references do |t|
      t.integer :note_id, null:false
      t.string :image
      t.string :url
      t.string :comment
    end
    add_foreign_key :references, :notes
  end

  def down
    drop_table :references
  end

end
