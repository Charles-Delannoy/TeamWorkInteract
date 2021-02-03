class AddIconToAxe < ActiveRecord::Migration[6.0]
  def change
    add_column :axes, :icon, :string
  end
end
