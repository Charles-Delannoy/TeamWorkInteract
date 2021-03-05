FactoryBot.define do
  factory :message do
    content { "MyString" }
    chatroom { nil }
    user { nil }
  end
end
