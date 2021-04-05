FactoryBot.define do
  factory :group do
    name { 'Millesime Manager' }
    description { 'Application de gestion de cave à vin' }
    start_date { Date.today - 10 }
    end_date { Date.today + 60 }
  end
end
