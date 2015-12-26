require 'rails_helper'

describe 'List relation types' do

  let(:response){ JSON.parse(page.text)['relation_types'] }

  before{ visit api_relation_types_path }

  context 'response' do
    it{ expect(response).to eq(
      %w(Acquaintance Advisor Aunt Betrothed Brother Counselor Courter Father
         Follower Friend Guide Home Husband King Located_in Maid Member Mother
         Near_sister Owner Player Practitioner Queen Resident Right_hand Sister
         Swordbearer Teacher Uncle Variant Warder Wielder)) }
  end

end
