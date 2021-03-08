class AddSeenAtToChatroomUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :chatroom_users, :seen_at, :date
  end
end
