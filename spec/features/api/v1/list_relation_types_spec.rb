require 'rails_helper'

describe 'List relation types' do

  let(:response){ JSON.parse(page.text)['relation_types'] }

  before{ visit api_relation_types_path }

  context 'response' do
    it{ expect(response).to eq(
      %w(Acquaintance Advisor Ancestor Aunt Betrothed Boyfriend Brother
         Companion Counselor Courter Cousin Creator Employee Enemy
         Father Follower Friend Girlfriend Guide Hearsay Home Husband
         Killer King Located_in Maid Member Mother Near_sister Owner
         Player Practitioner Queen Resident Right_hand Ruler
         Sister Swordbearer Teacher Uncle Variant Visitor Warder Wielder
         Worshiper)) }
  end

end
