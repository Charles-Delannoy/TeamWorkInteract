require 'rails_helper'

RSpec.describe Chatroom, type: :model do
  fixtures :users
  describe 'validation' do
    it 'should validate name presence' do
      chatroom = Chatroom.new
      chatroom.validate
      expect(chatroom.errors).to include(:name)
    end

    it 'should persist chatroom with correct validations' do
      n_chatroom = Chatroom.count
      chatroom = build(:chatroom)
      chatroom.save
      expect(Chatroom.count).to eq(n_chatroom + 1)
    end
  end

  describe 'associations' do
    it 'should be related with chatroom users' do
      chatroom = build(:chatroom)
      expect(chatroom.users.count).to eq(0)
      chatroom.chatroom_users << ChatroomUser.new(user: users(:chrystelle), chatroom: chatroom)
      chatroom.save
      expect(chatroom.users.count).to eq(1)
    end

    it 'should be related with messages' do
      chatroom = build(:chatroom)
      expect(chatroom.messages.count).to eq(0)
      chatroom.messages << Message.new(user: users(:chrystelle), chatroom: chatroom, content:'Hello there')
      chatroom.save
      expect(chatroom.messages.count).to eq(1)
    end
  end
end
