require 'active_record'
require './app/models/event'

require './config/database'

describe Event do

  describe "Validations" do

    let(:params){{}}
    subject{ ->{ Event.create params }}

    context "Event is valid" do
      it{ should change(Event,:count).from(0).to(1) }
      after do
        Event.delete_all
      end
    end

  end
end
