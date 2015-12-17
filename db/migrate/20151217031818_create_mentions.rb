class CreateMentions < ActiveRecord::Migration

  def up
    create_table :mentions do |t|
      t.integer :origin_id, null:false
      t.integer :target_id, null:false
    end
    add_foreign_key :mentions, :events, column: :origin_id
    add_foreign_key :mentions, :events, column: :target_id
    add_index :mentions, [:origin_id, :target_id], unique:true
  end

  def down
    drop_table :mentions
  end

end
