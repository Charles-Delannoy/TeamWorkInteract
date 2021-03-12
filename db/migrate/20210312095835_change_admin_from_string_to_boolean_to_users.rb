class ChangeAdminFromStringToBooleanToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin2, :boolean

    User.reset_column_information # make the new column available to model methods
    User.all.each do |user|
      user.admin2 = user.admin == 'Y' ? true : false
      user.save
    end

    remove_column :users, :admin
    rename_column :users, :admin2, :admin
  end
end
