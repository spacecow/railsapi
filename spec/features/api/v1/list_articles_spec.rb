describe 'List articles' do

  let(:universe){ create :universe }
  let(:article){ create :article, name:'Kelsier', universe:universe }
  let(:function){ visit api_articles_path }
  let(:body){ JSON.parse(page.text)["articles"] }

  context 'response' do
    before{ article; function }
    subject{ body }
    it{ is_expected.to eq([{
      'id'   => article.id,
      'name' => "Kelsier",
      'universe_id' => universe.id }]) }
  end

  after do
    Article.delete_all
    Universe.delete_all
  end

end
