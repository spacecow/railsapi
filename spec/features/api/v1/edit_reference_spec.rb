require 'rails_helper'

describe "Edit reference" do

  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :put, path, params }
  let(:response){ JSON.parse page.text }

  let(:note){ reference.note }
  let(:note_id){ note.id }
  let(:reference){ create :reference }
  let(:reference_id){ reference.id }
  let(:path){ api_reference_path reference }
  let(:params){{ reference:{ image_data:base64_image }}}
  let(:file){ File.open('spec/apple.jpg').read }
  let(:base64_image){ Base64.encode64 file }

  it "new reference is valid" do
    function
    expect(response["reference"]).to eq({
      "id" => reference_id,
      "note_id" => note_id,
      "url" => nil,
      "comment" => nil,
      "image_data" => base64_image
    })
  end

  after do
    Reference.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
