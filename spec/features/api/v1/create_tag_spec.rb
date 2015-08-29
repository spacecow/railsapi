require 'rails_helper'

describe "Create tag" do

  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :post, path, params }
  let(:response){ JSON.parse page.text }

  let(:tag){ Tag.first }
  let(:tag_id){ tag.id }
  let(:note){ create :note }
  let(:note_id){ note.id }
  let(:params){{ tag:{ title:'TDP'} }}
  let(:path){ api_tags_path }

  #TODO fyll i it text
  it "" do
    expect{ function }.to change(Tag, :count).from(0).to(1)
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
