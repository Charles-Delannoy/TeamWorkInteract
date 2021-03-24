require 'rails_helper'

RSpec.describe ChatroomUser, type: :model do
  fixtures :users
  fixtures :chatrooms
  describe 'validation' do
    it 'should validate chatroom existence' do
      chatroom_user = ChatroomUser.new
      chatroom_user.validate
      expect(chatroom_user.errors).to include(:chatroom)
      expect(chatroom_user.errors.messages[:chatroom]).to include("must exist")
    end

    it 'should validate user existence' do
      chatroom_user = ChatroomUser.new
      chatroom_user.validate
      expect(chatroom_user.errors).to include(:user)
      expect(chatroom_user.errors.messages[:user]).to include("must exist")
    end

    it 'should persist a chatroom_user if validations are ok' do
      n_chatroom_user = ChatroomUser.count
      chatroom_user = ChatroomUser.new
      chatroom_user.chatroom = chatrooms(:first_chatroom)
      chatroom_user.user = users(:chrystelle)
      chatroom_user.save
      expect(ChatroomUser.count).to eq(n_chatroom_user + 1)
    end
  end
end
