if FactoryGirl.factories.instance_variable_get('@items').empty?

  FactoryGirl.define do
    factory :book do
      title 'factory title'
      universe
    end

    factory :article do
      universe
      name 'factory name'
      type 'Character'
    end

    factory :note do
      article
      text 'factory text'
    end

    factory :reference do
      note
    end

    factory :tag do
      title 'factory title'
    end

    factory :tagging do
      tag
      association :tagable, factory: :note
    end

    factory :universe do
      sequence(:title){|n| "factory title#{n}"}
    end
  end

end
