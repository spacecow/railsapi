require 'rails_helper'

describe "List tags" do

  let(:function){ visit path }
  let(:response){ JSON.parse(page.text)['tags'] }

  let(:path){ api_tags_path }
  let(:params){{ title:'TDP' }}
  let(:tag){ create :tag, params }
  let(:tag_id){ tag.id }

  context "response" do
    before{ tag; function } 
    subject{ response }
    it{ should eq([{
      'id'          => tag_id, 
      'title'       => 'TDP' }]) }
  end

  after do
    Tag.delete_all
  end

end
