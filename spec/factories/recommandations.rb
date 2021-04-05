FactoryBot.define do
  factory :recommandation do
    title {"Neque porro"}
    description {"Lorem ipsum dolor sit amet"}

    factory :recommandation_empty do
      description {""}
    end
  end
end
