require 'rails_helper'

describe 'Show universe' do

  let(:universe){ create :universe, title:'The Final Empire' }
  let(:function){ visit api_universe_path universe }
  let(:body){ JSON.parse(page.text)['universe'] }

  context 'response' do
    before{ function }
    subject{ body }
    it{ is_expected.to eq({
      'id'    => Universe.first.id,
      'title' => 'The Final Empire' }) }
  end

  after{ Universe.delete_all }

end
