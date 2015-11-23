class CreateParticipations < ActiveRecord::Migration
  def up
    create_table :participations do |t|
      t.integer :event_id, null:false
      t.integer :article_id, null:false
      t.timestamps null:false
    end
    add_foreign_key :participations, :events
    add_foreign_key :participations, :articles
  end

  def down
    drop_table :participations
  end
end
