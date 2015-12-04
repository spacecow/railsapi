require 'rails_helper'

describe 'Show universe' do

  let(:body){ JSON.parse(page.text)['universe'] }

  context 'response' do
    before do
      universe = create :universe, title:'The Final Empire'
      create :article, name:'Vin', universe:universe
      visit api_universe_path universe
    end
    subject{ body }
    it{ is_expected.to eq({
      'id'       => Universe.first.id,
      'title'    => 'The Final Empire',
      'articles' => [
        'id'     => Article.first.id,
        'type'   => 'Character',
        'name'   => 'Vin',
        'gender' => 'n'
      ] }) }
  end

  after do
    Article.delete_all
    Universe.delete_all
  end

end
