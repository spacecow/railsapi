require 'rails_helper'

describe "List tags" do

  let(:function){ visit path }
  let(:response){ JSON.parse(page.text)[mdl_name.pluralize] }
  let(:path){ send "api_#{mdl_name.pluralize}_path", universe_id:universe.id }

  let(:mdl_name){ "tag" }
  let(:universe){ create :universe }
  let(:params){{ title:'TDP', universe_id:universe.id }}
  let(:mdl){ create mdl_name, params }
  let(:tag_id){ mdl.id }

  context "response" do
    before{ mdl; function } 
    subject{ response }
    it{ should eq([{
      'id'          => tag_id, 
      'title'       => 'TDP',
      'universe_id' => universe.id }]) }
  end

  after do
    Tag.delete_all
    Universe.delete_all
  end

end
