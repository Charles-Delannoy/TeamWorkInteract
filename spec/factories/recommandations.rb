FactoryBot.define do
  factory :recommandation do
    title {"Neque porro"}
    description {"Lorem ipsum dolor sit amet"}

    factory :recommandation_no_title do
      title { nil }
    end

    factory :recommandation_no_description do
      description {""}
    end
  end
end
