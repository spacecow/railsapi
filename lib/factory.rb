class Factory

  def create_event params; FactoryGirl.create :event, params end 
  def delete_events; Event.delete_all end

  def create_remark params; FactoryGirl.create :remark, params end

  def create_remarkable params; FactoryGirl.create :remarkable, params end

  def delete_universes; Universe.destroy_all end

end
