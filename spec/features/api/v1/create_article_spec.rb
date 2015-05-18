require 'rails_helper'

describe 'Create Article' do

  let(:params){ {article:{name:'Kelsier'}} }
  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :post, api_articles_path, params }

  context "a universe is selected" do
    it "" do
      expect(Article.count).to be 0
      function
      expect(Article.count).to be 1
    end
  end

  pending "no universe is selected"

  after{ Article.delete_all }

end
