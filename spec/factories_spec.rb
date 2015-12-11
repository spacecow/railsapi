require './spec/model_helper'
require './app/models/article'
require './app/models/universe'

describe "Factory Universe" do

  describe "creation" do
    it "of one" do
      expect{create :universe}.to change(
        Universe,:count).from(0).to(1)
    end

    it "of two" do
      create :universe
      expect{create :universe}.to change(
        Universe,:count).from(1).to(2)
    end
  end

  after{ Universe.delete_all }

end

describe "Factory Article" do

  describe "creation" do
    it "of one" do
      expect{create :article}.to change(
        Article,:count).from(0).to(1)
    end

    it "of two" do
      create :article
      expect{create :article}.to change(
        Article,:count).from(1).to(2)
    end
  end

  after do
    Article.delete_all
    Universe.delete_all
  end

end
