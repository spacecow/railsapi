class MigrateToArticleNotes < ActiveRecord::Migration

  def up
    Note.all.each do |note|
      ArticleNote.create note_id:note.id, article_id:note.article_id
    end
  end

  def down
    ArticleNote.delete_all
  end

end
