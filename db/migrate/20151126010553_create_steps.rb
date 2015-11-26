class CreateSteps < ActiveRecord::Migration
  def up
    create_table :steps do |t|
      t.integer :parent_id, null:false
      t.integer :child_id, null:false
      t.timestamps null:false
    end
    add_foreign_key :steps, :events, column: :parent_id
    add_foreign_key :steps, :events, column: :child_id
    add_index :steps, [:parent_id, :child_id], unique:true
  end

  def down
    drop_table :steps
  end
end

#    create_table :participations do |t|
#      t.integer :event_id, null:false
#      t.integer :article_id, null:false
#      t.timestamps null:false
#    end
#    add_foreign_key :participations, :events
#    add_foreign_key :participations, :articles
#    add_index :participations, [:event_id, :article_id], unique:true
#  end
#
#  def down
#    drop_table :participations
