require 'rails_helper'

describe "Delete note tag" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :delete }
  let(:path){ send "api_#{mdl_name}_path", mdl.id }

  let(:mdl_name){ "tag" }
  let(:mdl){ create mdl_name, universe_id:universe_id }
  let(:universe){ create :universe }
  let(:universe_id){ universe.id }
  let(:params){{ mdl_name => { tagable_id:note.id, tagable_type:"Note" }}}
  let(:note){ create :note }
  let(:tagging){ create :note_tag, note:note, tag:mdl }

  before{ tagging }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(NoteTag,:count).from(1).to(0).and(
           not_change(Tag,:count).from(1)).and(
           not_change(Note,:count).from(1)).and(
           not_change(Universe,:count).from(1))
    expect(page.status_code).to be 200
  end

  after do
    NoteTag.delete_all
    Tag.delete_all
    Note.delete_all
    Universe.delete_all
  end

end
