require 'rails_helper'

describe UniversesController do

  describe 'GET /universes' do
    let(:universe){ FactoryGirl.create :universe, title:'Malazan' }
    let(:function){ get :index }
    let(:body){ JSON.parse response.body }

    context "response" do
      before{ universe; function }
      subject{ body }
      it{ is_expected.to eq([{
        "id" => Universe.first.id,
        "title" => 'Malazan' }]) }
    end

    after{ Universe.delete_all }
  end
end
