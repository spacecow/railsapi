require 'rails_helper'

describe "Update note" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :put }
  let(:path){ send "api_#{mdl_name}_path", note }
  let(:response){ JSON.parse(page.text)[mdl_name] }

  let(:mdl_name){ "note" }
  let(:note){ create mdl_name, text:"an old note" }
  let(:params){{ mdl_name => { text:"an updated note" }}}

  before{ note }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should_not change(Note, :count) 
    expect(response).to eq({
      'id'          => note.id,
      'text'        => "an updated note",
      'tags'        => [],
      'references'  => [] })
    note.reload
    expect(note.text).to eq "an updated note"
  end

  after do
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
