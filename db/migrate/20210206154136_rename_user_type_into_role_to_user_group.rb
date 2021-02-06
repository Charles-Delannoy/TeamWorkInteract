class RenameUserTypeIntoRoleToUserGroup < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_groups, :user_type, :role
  end
end
