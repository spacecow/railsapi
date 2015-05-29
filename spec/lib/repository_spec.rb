require 'model_helper'
require './app/models/article'
require './app/models/book'
require './app/models/note'
require './app/models/universe'
require './lib/repository'

describe Repository do

  let(:article){ create :article }
  let(:article_id){ article.id }
  let(:book){ create :book }
  let(:book_id){ book.id }
  let(:repo){ Repository.new }
  let(:creation){ repo.create_note article_id, book_id }

  describe "#create_note" do
    it{ expect{creation}.to change(Note,:count).from(0).to(1) } 
  end

  after do
    Note.delete_all
    Article.delete_all
    Book.delete_all
    Universe.delete_all
  end

end
