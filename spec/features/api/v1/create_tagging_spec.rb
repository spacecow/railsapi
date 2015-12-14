require 'rails_helper'

describe "Create tagging" do

  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :post, path, params }
  let(:response){ JSON.parse page.text }

  let(:tagging){ NoteTag.first }
  let(:tag){ create :tag }
  let(:note){ create :note }
  let(:params){{ tagging:{ tagable_type:'Note', tagable_id:note.id, tag_id:tag.id }}}
  let(:path){ api_taggings_path }

  #TODO fyll i it text
  it "" do
    expect{ function }.to change(NoteTag, :count).from(0).to(1)
    expect(response["tagging"]).to eq({
      "id"      => tagging.id,
      "tag_id"  => tag.id,
      "note_id" => note.id })
  end

  after do
    NoteTag.delete_all
    Tag.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
