class DropIcons < ActiveRecord::Migration[6.0]
  def change
    drop_table :icons
  end
end
