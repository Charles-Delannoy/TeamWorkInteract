require 'rails_helper'

RSpec.describe Message, type: :model do
  fixtures :users
  fixtures :chatrooms
  describe 'validation' do
    it 'should validate content presence' do
      message = build(:message_no_content)
      message.validate
      expect(message.errors).to include(:content)
      expect(message.errors.messages[:content].first).to include("can't be blank")
    end

    it 'should validate content length: min 1' do
      message = build(:message_empty_content)
      message.validate
      expect(message.errors).to include(:content)
      expect(message.errors.messages[:content]).to include("is too short (minimum is 1 character)")
    end

    it 'should validate chatroom existence' do
      message = build(:message)
      message.validate
      expect(message.errors).to include(:chatroom)
      expect(message.errors.messages[:chatroom]).to include("must exist")
    end

    it 'should validate user existence' do
      message = build(:message)
      message.validate
      expect(message.errors).to include(:user)
      expect(message.errors.messages[:user]).to include("must exist")
    end

    it 'should persist a message if validations are ok' do
      n_messages = Message.count
      message = build(:message)
      message.chatroom = chatrooms(:first_chatroom)
      message.user = users(:chrystelle)
      message.save
      expect(Message.count).to eq(n_messages + 1)
    end
  end
end
