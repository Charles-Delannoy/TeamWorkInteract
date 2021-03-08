class ChangeSeenAtTypeToDateTimeInChatroomUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :chatroom_users, :seen_at, :datetime
  end
end
