require 'rails_helper'

describe "Create participation" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdl] }
  let(:function){ driver.submit mode, path, params }
  let(:path){ send("api_#{mdl.pluralize}_path") }

  let(:mode){ :post }
  let(:params){ {} }
  let(:mdl){ "participation" }

  subject{ ->{ function }}

  it "a participation is created" do
    should change(Participation,:count).from(0).to(1)
    expect(response).to eq({
    })
  end

  after do
    Participation.delete_all
  end

end
