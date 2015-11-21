class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.integer :universe_id, null:false
      t.timestamps null:false
    end
    add_foreign_key :events, :universes
  end

  def down
    drop_table :events
  end
end
