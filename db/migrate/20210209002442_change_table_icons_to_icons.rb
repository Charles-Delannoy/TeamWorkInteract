class ChangeTableIconsToIcons < ActiveRecord::Migration[6.0]
  def change
    rename_table :table_icons, :icons
  end
end
