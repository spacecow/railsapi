require 'rails_helper'

describe 'List books' do
  
  let(:universe){ create :universe }
  let(:book){ create :book, title:'Cryptonomicon', universe_id:universe.id }
  let(:body){ JSON.parse(page.text)['books'] }
  let(:function){ visit api_books_path }

  context 'response' do
    before{ book; function } 
    subject{ body }
    it{ is_expected.to eq([{
      'id'          => Book.first.id,
      'title'       => 'Cryptonomicon',
      'universe_id' => universe.id }]) }
  end

  after do
    Book.delete_all
    Universe.delete_all
  end

end
