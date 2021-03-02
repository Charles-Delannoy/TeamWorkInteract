FactoryBot.define do
  factory :axe do
    sequence(:title) { |i| "Title #{i}" }
  end
end
