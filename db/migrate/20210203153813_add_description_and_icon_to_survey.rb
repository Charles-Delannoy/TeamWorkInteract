class AddDescriptionAndIconToSurvey < ActiveRecord::Migration[6.0]
  def change
    add_column :surveys, :description, :text
    add_column :surveys, :icon, :string
  end
end
