require 'rails_helper'

describe 'List universes' do
  let(:universe){ create :universe, title:'Malazan' }
  let(:function){ visit universes_path }
  let(:body){ JSON.parse page.text }

  context "response" do
    before{ universe; function }
    subject{ body }
    it{ is_expected.to eq([{
      "id" => Universe.first.id,
      "title" => 'Malazan' }]) }
  end

  after{ Universe.delete_all }
end
