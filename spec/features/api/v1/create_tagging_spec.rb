require 'rails_helper'

describe "Create tagging" do

  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit mode, path, params }
  let(:mode){ :post }
  let(:path){ send "api_#{mdl_name.pluralize}_path" }

  let(:response){ JSON.parse(page.text)[mdl_name] }

  let(:tagging){ NoteTag.first }
  let(:universe){ create :universe }
  let(:tag){ create :tag, universe_id:universe.id }
  let(:note){ create :note }
  let(:params){{ mdl_name => { tagable_type:'Note', tagable_id:note.id, tag_id:tag.id }}}
  let(:mdl_name){ "tagging" }

  before{ tag; note }

  subject{ ->{ function }}

  it "Creates a note tag" do
    should change(NoteTag, :count).from(0).to(1).and(
           not_change(Tag, :count).from(1)).and( 
           not_change(Note, :count).from(1)).and(
           not_change(Universe, :count).from(1)).and(
           not_change(Article, :count).from(0))
    expect(response).to eq({
      "id"      => tagging.id,
      "tag_id"  => tag.id,
      "note_id" => note.id })
  end

  after do
    NoteTag.delete_all
    Tag.delete_all
    Note.delete_all
    Universe.delete_all
  end

end
