class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :title
      t.belongs_to :tagable, polymorphic:true
    end
    add_index :tags, [:tagable_id, :tagable_type]
  end
end
