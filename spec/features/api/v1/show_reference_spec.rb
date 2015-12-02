require 'rails_helper'

describe 'Show reference' do

  let(:file){ File.open('spec/apple.jpg').read }
  let(:base64_image){ Base64.encode64 file }
  let(:note){ reference.referenceable }
  let(:reference){ create :reference,
    url:'www.example.com', image_data:base64_image }
  let(:body){ JSON.parse(page.text)['reference'] }

  before{ visit api_reference_path reference }

  subject{ body }
 
  it "Reference exists" do
    is_expected.to eq({
      'id'                 => reference.id,
      'referenceable_id'   => note.id,
      'referenceable_type' => "Note",
      'url'                => 'www.example.com',
      'comment'            => nil,
      'image_data'         => base64_image
    }) 
  end

  after do
    Reference.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end
 
end
