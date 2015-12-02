require 'rails_helper'

describe "Create reference to note" do

  let(:driver){ Capybara.current_session.driver }
  let(:path){ send "api_#{mdl.pluralize}_path" }
  let(:mode){ :post }
  let(:mdl){ "reference" }

  let(:file){ File.open('spec/apple.jpg').read }
  let(:base64_image){ Base64.encode64 file }

  let(:params){{ reference:{ referenceable_id:note.id, image_data:base64_image,
                 url:'www.example.com', comment:'smart', referenceable_type:"Note" }}}
  let(:note){ create :note }
  let(:reference){ Reference.first }

  subject{ ->{ driver.submit mode, path, params }}

  context "reference is valid" do
    it "a reference is created" do
      should change(Reference,:count).from(0).to(1)
      expect(reference.referenceable.id).to be note.id 
      expect(reference.as_json).to eq({
        "id"                 => reference.id,
        "referenceable_id"   => note.id,
        "referenceable_type" => "Note",
        "url"                => "www.example.com",
        "comment"            => "smart",
        "image_data"         => base64_image })
    end
  end

  after do
    Reference.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
