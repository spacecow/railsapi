require 'rails_helper'

describe 'Delete books' do

  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :delete, api_books_path, nil }
  let(:response){ JSON.parse page.text }

  describe 'success' do
    it 'all books are deleted' do
      begin
        book = create :book, title:'Cryptonomicon'
        expect(Book.count).to be 1
        function
        expect(Book.count).to be 0
        expect(response['books']).to eq([{
          'id' => book.id,
          'title' => 'Cryptonomicon',
          'universe_id' => book.universe_id }])
      ensure
        Book.delete_all
        Universe.delete_all
      end
    end
  end
 
end
