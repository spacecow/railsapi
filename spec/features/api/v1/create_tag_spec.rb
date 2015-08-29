require 'rails_helper'

describe "Create tag" do

  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :post, path, params }
  let(:response){ JSON.parse page.text }

  let(:note){ create :note }
  let(:note_id){ note.id }
  let(:tag){ Tag.first }
  let(:tag_id){ tag.id }
  let(:path){ api_tags_path }
  let(:params){{ tag:{ title:'TDP'} }}

  #TODO fyll i it text
  #TODO use {}.to change
  it "" do
    expect(Tag.count).to be 0
    function
    expect(Tag.count).to be 1
    expect(response["tag"]).to eq({
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
