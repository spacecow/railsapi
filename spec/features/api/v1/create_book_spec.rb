require 'rails_helper'

describe 'Create book' do

  let(:universe){ create :universe }
  let(:params){ {book:{title:'Cryptonomicon', universe_id:universe.id}} }
  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :post, api_books_path, params }
  let(:response){ JSON.parse(page.text) }

  context 'book is valid' do
    it 'an book is created' do
      begin
        expect(Book.count).to be 0
        function
        expect(Book.count).to be 1
        expect(response["book"]).to eq({
          'id'          => Book.first.id,
          'title'       => 'Cryptonomicon',
          'universe_id' => universe.id })
      ensure
        Book.delete_all
        Universe.delete_all
      end
    end
  end

end
