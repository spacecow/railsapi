class Factory

  def create_article_note params; FactoryGirl.create :article_note, params end
  def delete_article_notes; ArticleNote.destroy_all end

  def create_event params; FactoryGirl.create :event, params end 
  def delete_events; Event.delete_all end

  def create_note params; FactoryGirl.create :note, params end 
  def notes; Note.all end

  def create_remark params; FactoryGirl.create :remark, params end

  def create_remarkable params; FactoryGirl.create :remarkable, params end

  def delete_universes; Universe.destroy_all end

end
