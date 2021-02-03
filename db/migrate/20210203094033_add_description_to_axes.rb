class AddDescriptionToAxes < ActiveRecord::Migration[6.0]
  def change
    add_column :axes, :description, :text
  end
end
