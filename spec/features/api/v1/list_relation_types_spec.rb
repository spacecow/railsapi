require 'rails_helper'

describe 'List relation types' do

  let(:response){ JSON.parse(page.text)['relation_types'] }

  before{ visit api_relation_types_path }

  context 'response' do
    it{ expect(response).to eq(
      %w(Acquaintance Advisor Aunt Brother Counselor Courter Follower Guide
         Husband King Owner Queen Right_hand Sister Uncle Warder)) }
  end

end
