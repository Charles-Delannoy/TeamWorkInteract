class Chatroom < ApplicationRecord
  has_many :chatroom_users, dependent: :destroy
  has_many :users, through: :chatroom_users
  has_many :messages

  def new_message_counter(current_user)
    @last_message_send_date = messages.where(user: current_user).last.created_at
    @last_seen_date = chatroom_users.where(user: current_user).first.seen_at
    @new_messages = messages.where("created_at > :last_message_date AND created_at > :last_seen_date",
                                   last_message_date: @last_message_send_date, last_seen_date: @last_seen_date)
    @new_messages.count
  end
end