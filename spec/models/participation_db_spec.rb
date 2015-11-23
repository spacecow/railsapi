require 'active_record'
require './config/database'
require './app/models/participation'

describe Participation do

  describe "Validations" do
    
    subject{ ->{ Participation.create }}

    context "Participation is valid" do
      it{ should change(Participation,:count).from(0).to(1) }
      after{ Participation.delete_all }
    end

  end

end
