require 'rails_helper'

describe "Create tag" do

  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit mode, path, params }
  let(:response){ JSON.parse(page.text)[mdl] }
  let(:path){ send("api_#{mdl.pluralize}_path") }

  let(:tag){ Tag.first }
  let(:tag_id){ tag.id }
  let(:note){ create :note }
  let(:note_id){ note.id }
  let(:mode){ :post }
  let(:params){{ tag:{ title:'TDP'} }}
  let(:mdl){ "tag" }

  subject{ ->{ function }}

  it "a tag is created" do
    should change(Tag, :count).from(0).to(1)
    expect(response).to eq({
      "id" => tag_id,
      "title" => 'TDP',
    })
  end

  after do
    Tag.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
