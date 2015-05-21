require 'rails_helper'

describe 'Delete universes' do

  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :delete, api_universes_path, nil }
  let(:response){ JSON.parse page.text }

  context 'success' do
    it 'all universes are deleted' do
      universe = create :universe, title:'Malazan'
      expect(Universe.count).to be 1
      function
      expect(Universe.count).to be 0
      expect(response['universes']).to eq([{
        'id' => universe.id,
        'title' => 'Malazan' }])
    end
  end

end
