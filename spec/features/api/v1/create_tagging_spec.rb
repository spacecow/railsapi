require 'rails_helper'

describe "Create tagging" do

  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :post, path, params }
  let(:response){ JSON.parse page.text }

  let(:tagging){ Tagging.first }
  let(:tagging_id){ tagging.id }
  let(:tag){ create :tag }
  let(:tag_id){ tag.id }
  let(:note){ create :note }
  let(:note_id){ note.id }
  let(:params){{ tagging:{ tagable_type:'Note', tagable_id:note_id, tag_id:tag_id }}}
  let(:path){ api_taggings_path }

  #TODO fyll i it text
  it "" do
    expect{ function }.to change(Tagging, :count).from(0).to(1)
    expect(response["tagging"]).to eq({
      "id"           => tagging_id,
      "tag_id"       => tag_id,
      "tagable_id"   => note_id,
      "tagable_type" => "Note"
    })
  end

  after do
    Tagging.delete_all
    Tag.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
