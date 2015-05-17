require 'rails_helper'

describe 'List universes' do
  let(:universe){ create :universe, title:'Malazan' }
  let(:function){ visit api_universes_path }
  let(:body){ JSON.parse(page.text)["universes"] }
  let(:driver){ Capybara.current_session.driver }
  let(:header){ driver.header 'Accept', 'application/vnd.example.v1' }

  context "response" do
    before{ header; universe; function }
    subject{ body }
    it{ is_expected.to eq([{
      "id" => Universe.first.id,
      "title" => 'Malazan' }]) }
  end

  after{ Universe.delete_all }
end
