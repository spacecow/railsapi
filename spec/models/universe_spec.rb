require 'active_record'
require './config/database'
require './app/models/universe'

describe Universe do
  let(:title){ 'Malazan' }
  let(:universe){ Universe.create title:title } 

  it{ expect{universe}.to change(
    Universe,:count).by(1) }

  context "title is not set" do
    let(:title){ nil }
    it{ expect{universe}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
    }} 
  end

  context "title is duplicated" do
    before{ Universe.create title:title }
    it{ expect{universe}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::RecordNotUnique
    }} 
  end

  after{ Universe.delete_all }

end
