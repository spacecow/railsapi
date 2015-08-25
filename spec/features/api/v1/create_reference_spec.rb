require 'rails_helper'

describe "Create reference" do

  let(:file){ File.open('spec/apple.jpg').read }
  let(:base64_image){ Base64.encode64 file }
  let(:note){ create :note }
  let(:params){{ reference:{ note_id:note.id, image_data:base64_image,
    url:'www.example.com', comment:'smart' }}}
  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :post, path, params }
  let(:path){ api_references_path }
  let(:response){ JSON.parse page.text }
  let(:reference){ Reference.first }
  let(:reference_id){ reference.id }

  context "reference is valid" do
    it "a reference is created" do
      expect(Reference.count).to be 0
      function
      expect(Reference.count).to be 1
      expect(response["reference"]).to eq({
        "id"         => reference_id,
        "note_id"    => note.id,
        "url"        => "www.example.com",
        "comment"    => "smart",
        "image_data" => base64_image })
    end
  end

  after do
    Reference.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
