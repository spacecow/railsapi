describe "Relation" do

  let(:relation){ Relation.new }

  before do
    module ActiveRecord; class Base
      def self.belongs_to mdl, *opts; end
      def self.has_many mdls, *opts; end
    end end unless defined?(Rails)
    require './app/models/relation'
  end

  subject{ relation.send function, *params }

  describe '.inverse_type' do
    let(:relation){ Relation }
    let(:function){ :inverse_type }
    
    context "Not dependent on gender" do
      let(:params){ "RightHand" }
      it{ should eq "Commander" }
    end

    context "Dependent on gender" do
      describe "Neutral" do
        let(:params){ ["Uncle", 'n'] }
        it{ should eq "Nephew" }
      end
      describe "Male" do
        let(:params){ ["Uncle", 'm'] }
        it{ should eq "Nephew" }
      end
      describe "Female" do
        let(:params){ ["Uncle", 'f'] }
        it{ should eq "Niece" }
      end
    end
  end

end 
