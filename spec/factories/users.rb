FactoryBot.define do
  factory :user do
    sequence(:first_name) { |i| "Prénom#{i}" }
    sequence(:last_name) { |i| "Nom#{i}" }
    sequence(:email) { |i| "prénom#{i}.nom#{i}@twi.com" }
    password { 'aaaaaa' }
    admin { true }

    factory :user_no_last_name do
      last_name { nil }
    end

    factory :user_no_first_name do
      first_name { nil }
    end
  end
end
