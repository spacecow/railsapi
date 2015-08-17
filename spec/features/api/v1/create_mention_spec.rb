require 'rails_helper'

describe "Create mention" do

  let(:file){ File.open('spec/apple.jpg').read }
  let(:base64_image){ Base64.encode64 file }
  let(:note){ create :note }
  let(:params){{ mention:{ note_id:note.id, image_data:base64_image }}}
  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :post, api_mentions_path, params }
  let(:response){ JSON.parse page.text }
  let(:mention){ Mention.first }
  let(:mention_id){ mention.id }

  context "mention is valid" do
    it "a mention is created" do
      expect(Mention.count).to be 0
      function
      expect(Mention.count).to be 1
      expect(response["mention"]).to eq({
        "id" => mention_id,
        "note_id" => note.id,
        "image" => {
          "url" => "/uploads/test/mention/image/#{mention_id}/photo.jpeg" }})
    end
  end

  after do
    Mention.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
