require 'rails_helper'

describe 'Delete references' do

  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :delete, path, nil }
  let(:response){ JSON.parse page.text }

  let(:path){ api_references_path }
  let(:note){ reference.note }
  let(:note_id){ note.id }
  let(:reference){ create :reference, params }
  let(:reference_id){ reference.id }

  let(:file){ File.open('spec/apple.jpg').read }
  let(:base64_image){ Base64.encode64 file }
  let(:params){{ url:'www.example.com', image_data:base64_image }}

  it "existing references are deleted" do
    reference
    expect{ function }.to change(Reference,:count).from(1).to(0)
    expect(response['references']).to eq([{
      'id'         => reference_id,
      'note_id'    => note_id,
      'url'        => 'www.example.com',
      'image_data' => base64_image
    }])
  end

  after do
    Reference.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end
 
end
