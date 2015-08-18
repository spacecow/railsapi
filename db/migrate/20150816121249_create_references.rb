class CreateReferences < ActiveRecord::Migration

  def up
    create_table :references do |t|
      t.integer :note_id, null:false
      t.string :image
    end
    add_foreign_key :references, :notes
  end

  def down
    drop_table :references
  end

end
