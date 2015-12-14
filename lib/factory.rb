class Factory

  def create_article_note params; FactoryGirl.create :article_note, params end
  def delete_article_notes; ArticleNote.destroy_all end

  def create_event params; FactoryGirl.create :event, params end 
  def delete_events; Event.delete_all end

  def create_event_note params; FactoryGirl.create :event_note, params end
  def delete_event_notes; EventNote.destroy_all end

  def create_note params; FactoryGirl.create :note, params end 

  def create_tag tagable_type:, tagable_id:, **params
    tag = Tag.create params
    tagable_type.constantize.find(tagable_id).taggings.create tag_id:tag.id
    tag
  end

  def delete_universes; Universe.destroy_all end

end
