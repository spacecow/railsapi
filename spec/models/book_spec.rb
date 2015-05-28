require 'model_helper'
require './app/models/universe'
require './app/models/book'

describe Book do

  let(:title){ 'Cryptonomicon' }
  let(:universe){ create :universe }
  let(:universe_id){ universe.id }
  let(:model){ Book.create title:title, universe_id:universe_id }

  context "book is valid" do
    it{ expect{model}.to change(Book, :count).from(0).to(1) }
  end

  context "title is blank" do
    let(:title){ '' }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid }} 
  end

  context "title is null" do
    let(:title){ nil }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid }} 
  end

  context "universe_id is null" do
    let(:universe_id){ nil }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid }} 
  end

  context "universe_id is pointing at a non-existing universe" do
    let(:universe_id){ -1 }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid }} 
  end

  context "title is unique within a universe" do
    before{ create :book, title:'Cryptonomicon', universe_id:universe_id } 
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::RecordNotUnique }} 
  end

  context "title is not unique over all universes" do
    before{ create :book, title:'Cryptonomicon' } 
    it{ expect{model}.to change(Book, :count).from(1).to(2) }
  end

  after do
    Book.delete_all
    Universe.delete_all
  end

end
