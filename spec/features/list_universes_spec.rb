require 'rails_helper'

describe 'GET /universes' do

  before do
    Universe.create title:'Malazan'
    visit universes_path :json
  end

  context "response" do
    subject{ JSON.parse page.text }
    it{ is_expected.to eq([{
      "id" => Universe.first.id,
      "title" => 'Malazan' }]) }
  end

  after{ Universe.delete_all }

end
