class RemoveDateToSurveys2 < ActiveRecord::Migration[6.0]
  def change
    remove_column :surveys, :start_date
    remove_column :surveys, :end_date
  end
end
