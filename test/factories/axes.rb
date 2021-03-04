FactoryBot.define do
  factory :axe do
    sequence(:title) { |i| "Title #{i}" }
    sequence(:description) { |i| "Ma super description #{i}" }
  end
end
