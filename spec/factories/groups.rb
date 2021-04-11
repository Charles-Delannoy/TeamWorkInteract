FactoryBot.define do
  factory :group do
    name { 'Millesime Manager' }
    description { 'Application de gestion de cave à vin' }
    start_date { Date.today - 10 }
    end_date { Date.today + 60 }

    factory :group_no_name do
      name { nil }
    end

    factory :group_short_name do
      name { 'na' }
    end

    factory :group_short_description do
      description { 'a group' }
    end

    factory :group_no_description do
      description { nil }
    end

    factory :group_no_start do
      start_date { nil }
    end

    factory :group_no_end do
      end_date { nil }
    end

    factory :group_start_after_end do
      start_date { Date.today + 90 }
    end
  end
end
