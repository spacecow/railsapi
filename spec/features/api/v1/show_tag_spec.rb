require 'rails_helper'

describe 'Show tag' do

  let(:body){ JSON.parse(page.text)['tag'] }
  let(:tag){ create :tag, title:'TDP' }

  subject{ body }

  before{ visit api_tag_path tag }

  it "Tag exists" do
    should eq({
      'id'    => tag.id,
      'title' => 'TDP'
    })
  end

  after do
    Tag.delete_all
  end

end
