require 'rails_helper'

describe 'List books' do
  
  let(:function){ visit path }
  let(:response){ JSON.parse(page.text)['books'] }

  let(:path){ api_books_path(universe_id:universe.id) }
  let(:params){{ title:'Cryptonomicon', universe_id:universe.id }}
  let(:universe){ create :universe }
  let(:book){ create :book, params }
  let(:book_id){ book.id }

  context 'response' do
    before{ book; function } 
    subject{ response }
    it{ is_expected.to eq([{
      'id'          => book_id,
      'title'       => 'Cryptonomicon',
      'universe_id' => universe.id }]) }
  end

  after do
    Book.delete_all
    Universe.delete_all
  end

end
