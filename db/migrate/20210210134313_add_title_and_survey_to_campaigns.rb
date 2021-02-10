class AddTitleAndSurveyToCampaigns < ActiveRecord::Migration[6.0]
  def change
    add_column :campaigns, :title, :string
    add_reference :campaigns, :survey, null: false, foreign_key: true
    add_column :campaigns, :start_date, :date
    add_column :campaigns, :end_date, :date
  end
end
