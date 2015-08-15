require 'rails_helper'

describe 'Create note' do

  let(:article){ create :article }
  let(:params){ {note:{article_id:article.id, text:'a note'}} }
  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :post, api_notes_path, params }
  let(:response){ JSON.parse page.text }

  context 'note is valid' do
    it 'a note is created' do
      begin
        expect(Note.count).to be 0
        function
        expect(Note.count).to be 1
        expect(response["note"]).to eq({
          'id'          => Note.first.id,
          'article_id'  => article.id,
          'text'        => 'a note' })
      ensure
        Note.delete_all
        Article.delete_all
        Universe.delete_all
      end
    end
  end

end
