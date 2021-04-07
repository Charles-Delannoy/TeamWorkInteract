FactoryBot.define do
  factory :campaign do
    title { "My campaign" }
    start_date { Date.today }
    end_date { Date.today + 30 }

    factory :campaign_no_title do
      title { nil }
    end

    factory :campaign_short_title do
      title { 'abc' }
    end

    factory :campaign_no_start do
      start_date { nil }
    end

    factory :campaign_no_end do
      end_date { nil }
    end

    factory :campaign_start_after_en do
      start_date { Date.today + 40 }
    end
  end
end
