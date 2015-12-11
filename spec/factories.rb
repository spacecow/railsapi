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

    factory :article_note do
      article
      note
    end

    factory :event do
      universe
      title 'factory title'
    end

    factory :note do
      article
      text 'factory text'
    end

    factory :participation do
      association :participant, factory: :article
      event
    end

    factory :reference do
      association :referenceable, factory: :note
    end

    factory :relation do
      type "Owner"
      association :origin, factory: :article
      association :target, factory: :article
    end

    factory :remark do
      remarkable
      content "factory content"
    end

    factory :remarkable do
    end

    factory :step do
      association :parent, factory: :event
      association :child, factory: :event
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
