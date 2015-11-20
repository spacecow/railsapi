require 'active_record'
require './config/database'
require './lib/repository'

require 'factory_girl'
require './spec/factories'
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

describe Repository do

  let(:repository){ Repository.new }

  subject{ repository.send function, *params }

  describe "#tag" do
    def create_tagging n 
      create :tagging, tagable_id:n.id, tag_id:tag.id, tagable_type:'Note'
    end
    let(:function){ :tag }
    let(:tag){ create :tag, title:"TDP" }
    let(:note1){ create :note, text:'90 W' }
    let(:note2){ create :note, text:'120 W' }
    let(:note3){ create :note, text:'60 W' }
    let(:tagging){ create_tagging note1 }
    let(:tagging2){ create_tagging note2 }
    let(:tagging3){ create_tagging note3 }
    let(:params){ tag.id }
    before do
      require './app/models/universe'
      require './app/models/article'
      require './app/models/note'
      require './app/models/tag'
      require './app/models/tagging'
      tagging; tagging2; tagging3
    end
    it "" do
      should eq(
      { 'id'    => tag.id,
        'title' => 'TDP',
        'notes' =>
        [{'id' => note1.id,
          'text' => '90 W'},
         {'id' => note2.id,
          'text' => '120 W'},
         {'id' => note3.id,
          'text' => '60 W'}]
      })
    end

    after do
      Tagging.delete_all
      Tag.delete_all
      Note.delete_all
      Article.delete_all
      Universe.delete_all
    end
  end

end
