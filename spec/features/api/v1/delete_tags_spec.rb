require 'rails_helper'

describe "Delete tags" do

  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :delete, path, nil }
  let(:response){ JSON.parse page.text }

  let(:path){ api_tags_path }
  let(:note){ tag.tagable }
  let(:note_id){ note.id }
  let(:tag){ create :tag }

  it "existing tags are deleted" do
    tag
    expect{ function }.to change(Tag,:count).from(1).to(0)
    expect(response['tags']).to eq([{
      'id'           => tag.id,
      'title'        => 'factory title',
      'tagable_id'   => note_id,
      'tagable_type' => 'Note'
    }])
  end  

  after do
    Tag.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
