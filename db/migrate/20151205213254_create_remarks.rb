class CreateRemarks < ActiveRecord::Migration

  def up
    create_table :remarks do |t|
      t.integer :remarkable_id, null:false
      t.string :content, null:false
      t.timestamps null:false
    end
    execute "ALTER TABLE remarks ADD CONSTRAINT content_cannot_be_blank " +
            "CHECK (char_length(content) <> 0)"
    add_foreign_key :remarks, :remarkables
  end

  def down
    drop_table :remarks
  end

end
