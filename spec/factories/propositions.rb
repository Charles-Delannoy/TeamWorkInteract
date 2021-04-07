FactoryBot.define do
  factory :proposition do
    sequence(:title) { |i| "Proposition #{i}" }
  end
end
