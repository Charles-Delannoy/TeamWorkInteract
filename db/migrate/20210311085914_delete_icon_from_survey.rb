class DeleteIconFromSurvey < ActiveRecord::Migration[6.0]
  def change
    remove_column :surveys, :icon
  end
end
