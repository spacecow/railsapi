require 'rails_helper'

describe 'Show reference' do

  let(:file){ File.open('spec/apple.jpg').read }
  let(:base64_image){ Base64.encode64 file }
  let(:note){ reference.note }
  let(:note_id){ note.id }
  let(:reference){ create :reference,
    url:'www.example.com', image_data:base64_image }
  let(:body){ JSON.parse(page.text)['reference'] }

  before do
    visit api_reference_path reference
  end

  subject{ body }
 
  it "Reference exists" do
    is_expected.to eq({
      'id'         => reference.id,
      'note_id'    => note_id,
      'url'        => 'www.example.com',
      'image_data' => base64_image
    }) 
  end

  after do
    Reference.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end
 
end
