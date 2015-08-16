class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.string :image
    end
  end
end
