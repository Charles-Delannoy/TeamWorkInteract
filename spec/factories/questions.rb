FactoryBot.define do
  factory :question do
    sequence(:title) { |i| "Ma question #{i}" }
    coef { 1 }

    factory :question_no_title do
      title { nil }
    end

    factory :question_short_title do
      title { 'qu' }
    end

    factory :question_no_coef do
      coef { nil }
    end

    factory :question_coef2 do
      coef { 2 }
    end

    factory :question_negative_coef do
      coef { -2 }
    end
  end
end
