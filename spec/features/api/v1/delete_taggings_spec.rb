require 'rails_helper'

describe "Delete taggins" do

  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :delete, path, nil }
  let(:response){ JSON.parse page.text }

  let(:path){ api_taggings_path }
  let(:tag){ tagging.tag }
  let(:tag_id){ tag.id }
  let(:tagging){ create :tagging }
  let(:taggings_id){ tagging.id }
  let(:note){ tagging.tagable }
  let(:note_id){ note.id } 

  it "existing taggingss are deleted" do
    tagging
    expect{ function }.to change(Tagging,:count).from(1).to(0)
    expect(response['taggings']).to eq([{
      'id'           => taggings_id,
      'tag_id'       => tag_id,
      'tagable_type' => 'Note',
      'tagable_id'   => note_id
    }])
  end  

  after do
    Tag.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
