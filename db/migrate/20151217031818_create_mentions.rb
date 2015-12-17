class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.integer :origin_id
      t.integer :target_id
    end
  end
end
