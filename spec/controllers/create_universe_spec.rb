require 'rails_helper'

describe UniversesController do

  describe 'POST /universes' do
    let(:params){{ title:'Malazan' }}
    let(:function){ post :create, params }
    let(:body){ JSON.parse response.body }

    context "success" do
      it{ expect{function}.to change(
        Universe,:count).by(1) }
        
      context "response" do
        before{ function }
        subject{ body }
        it{ is_expected.to eq({
          "id" => Universe.first.id,
          "title" => 'Malazan' }) }
      end

      after{ Universe.delete_all }
    end

    context "failure" do
      let(:params){ {} }

      it{ expect{function}.to_not change(
        Universe,:count) }

      context "response" do
        before{ function }
        subject{ body }
        it{ is_expected.to have_key 'error' }
      end
    end

  end
end
