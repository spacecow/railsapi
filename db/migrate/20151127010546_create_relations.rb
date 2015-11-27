class CreateRelations < ActiveRecord::Migration

  def up
    create_table :relations do |t|
      t.integer :origin_id, null:false
      t.integer :target_id, null:false
      t.string :type, null:false
      t.timestamps null:false
    end
    execute "ALTER TABLE relations ADD CONSTRAINT type_cannot_be_blank " \
            "CHECK (char_length(type) <> 0)"
    add_foreign_key :relations, :articles, column: :origin_id
    add_foreign_key :relations, :articles, column: :target_id
    add_index :relations, [:origin_id, :target_id], unique:true
  end

  def down
    drop_table :relations
  end

end
