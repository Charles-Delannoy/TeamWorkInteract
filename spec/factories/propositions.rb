FactoryBot.define do
  factory :proposition do
    sequence(:title) { |i| "Proposition #{i}" }
    sequence(:value) { |i| i }

    factory :proposition_no_title do
      title { nil }
    end

    factory :proposition_short_title do
      title { 'pr' }
    end

    factory :proposition_no_value do
      value { nil }
    end

    factory :proposition_negative_value do
      value { -4 }
    end
  end
end
