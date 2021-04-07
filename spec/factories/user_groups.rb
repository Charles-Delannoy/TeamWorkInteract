FactoryBot.define do
  factory :user_group do
    role { 'M' }
    factory :user_group_referent do
      role { 'R' }
    end
  end
end
