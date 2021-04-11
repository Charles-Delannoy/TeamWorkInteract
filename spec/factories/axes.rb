FactoryBot.define do
  factory :axe do
    sequence(:title) { |i| "Title #{i}" }
    sequence(:description) { |i| "Ma super description #{i}" }
    factory :axe_no_title do
      title { nil }
    end
    factory :axe_short_title do
      title { 'ax' }
    end
    factory :axe_no_description do
      description { nil }
    end
    factory :axe_short_description do
      description { 'un axe' }
    end
  end
end
