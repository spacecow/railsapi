class CreateTags < ActiveRecord::Migration

  def up
    create_table :tags do |t|
      t.string :title, null:false
    end
    execute "ALTER TABLE tags ADD CONSTRAINT title_cannot_be_blank CHECK (char_length(title) <> 0)"
  end

  def down
    drop_table :tags
  end

end
