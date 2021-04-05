FactoryBot.define do
  factory :question do
    sequence(:title) { |i| "Ma question #{i}" }
    sequence(:coef) { 1 }
    factory :question_coef2 do
      sequence(:coef) { 2 }
    end
  end
end
