require 'rails_helper'

describe 'Delete universes' do
  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :delete, universes_path, nil }
  let(:body){ JSON.parse page.text }

  context "success" do
    it "" do
      universe = create :universe, title:'Malazan'
      expect(Universe.count).to be 1
      function
      expect(Universe.count).to be 0
      expect(body["universes"]).to eq([{
        "id" => universe.id,
        "title" => 'Malazan' }])
    end
  end

  after{ Universe.delete_all }

end
