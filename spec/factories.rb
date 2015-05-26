if FactoryGirl.factories.instance_variable_get('@items').empty?
  FactoryGirl.define do
    factory :article do
      name 'factory name'
      type 'Character'
      universe
    end

    factory :universe do
      sequence(:title){|n| "factory title#{n}"}
    end
  end
end
