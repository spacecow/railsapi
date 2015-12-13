class DropRemarks < ActiveRecord::Migration

  def up
    drop_table :remarks

    remove_foreign_key :events, :remarkables
    remove_column :events, :remarkable_id

    drop_table :remarkables
  end

  def down
    create_table :remarkables do |t|
      t.timestamps null:false
    end

    create_table :remarks do |t|
      t.integer :remarkable_id, null:false
      t.string :content, null:false
      t.timestamps null:false
    end
    execute "ALTER TABLE remarks ADD CONSTRAINT content_cannot_be_blank " +
            "CHECK (char_length(content) <> 0)"
    add_foreign_key :remarks, :remarkables

    add_column :events, :remarkable_id, :integer
    add_foreign_key :events, :remarkables
  end

end
