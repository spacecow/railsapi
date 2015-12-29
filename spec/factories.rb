if FactoryGirl.factories.instance_variable_get('@items').empty?

  FactoryGirl.define do
    factory :article do
      universe
      name 'factory name'
      type 'Character'
    end

    factory :article_mention do
      association :origin, factory: :article
      association :target, factory: :article
    end

    factory :article_note do
      article
      note
    end

    factory :article_tag do
      article
      tag
    end

    factory :book do
      title 'factory title'
      universe
    end

    factory :citation do
      content "factory content"
      association :origin, factory: :article
    end

    factory :event do
      universe
      title 'factory title'
    end

    factory :event_note do
      event
      note
    end

    factory :mention do
      association :origin, factory: :event
      association :target, factory: :event
    end

    factory :note do
      text 'factory text'
    end

    factory :note_tag do
      note
      tag
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

    factory :step do
      association :parent, factory: :event
      association :child, factory: :event
    end

    factory :tag do
      title 'factory title'
    end

    factory :universe do
      sequence(:title){|n| "factory title#{n}"}
    end
  end

end
