class CreateRemarkables < ActiveRecord::Migration

  def up
    create_table :remarkables do |t|
      t.timestamps null:false
    end
  end

  def down
    drop_table :remarkables
  end

end
