require 'rails_helper'

describe 'List article types' do

  let(:function){ visit api_article_types_path }
  let(:body){ JSON.parse(page.text)['article_types'] }

  context 'response' do
    before{ function }
    subject{ body }
    it{ is_expected.to eq(%w(Character Family Item Location Race Religion Structure)) }
  end

end
