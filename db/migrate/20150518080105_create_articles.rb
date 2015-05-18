class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles do |t|
      t.string :name
    end
  end

  def down
    drop_table :articles
  end
end
