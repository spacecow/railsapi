class AddGenderToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :gender, :string, limit:1, default:'n'
  end
end
