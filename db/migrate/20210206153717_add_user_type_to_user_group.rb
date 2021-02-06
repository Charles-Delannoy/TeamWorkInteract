class AddUserTypeToUserGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :user_groups, :user_type, :string
  end
end
