class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles do |t|
      t.string :name, null:false
      t.integer :universe_id, null:false
      t.string :type
    end
    add_foreign_key :articles, :universes
  end

  def down
    drop_table :articles
  end
end
