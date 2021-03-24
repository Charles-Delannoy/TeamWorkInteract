FactoryBot.define do
  factory :message do
    content { "MyString" }

    factory :message_no_content do
      content { nil }
    end

    factory :message_empty_content do
      content { '' }
    end
  end
end
