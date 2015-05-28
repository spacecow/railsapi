if FactoryGirl.factories.instance_variable_get('@items').empty?

  FactoryGirl.define do
    factory :book do
      universe
    end

    factory :article do
      universe
      name 'factory name'
      type 'Character'
    end

    factory :universe do
      sequence(:title){|n| "factory title#{n}"}
    end
  end

end
