require 'rails_helper'

describe "List articles" do

  let(:response){ JSON.parse(page.text)['articles'] }

  subject{ response }

  context "events response" do
    let(:article){ create :article, name:"Ethenielle" }
    before do
      article
      visit api_articles_path(universe_id:article.universe_id)
    end
    it{ should eq(
    [ 'id'    => article.id,
      'name'  => "Ethenielle",
      'type'  => "Character" ])}
  end

  after do
    Article.delete_all
    Universe.delete_all
  end

end
