class CreateTableCampaigns < ActiveRecord::Migration[6.0]
  def change
    create_table :table_campaigns do |t|
      t.references :group, null: false, foreign_key: true
      t.references :survey, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
    end
  end
end
