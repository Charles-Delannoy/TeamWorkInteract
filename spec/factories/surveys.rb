FactoryBot.define do
  factory :survey do
    title {"Mon questionnaire"}
    description {"Descritpion de mon questionnaire"}

    factory :survey_no_title do
      title {""}
    end

    factory :survey_no_description do
      description {""}
    end
  end
end
