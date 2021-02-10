class AddTimestampToCampaigns < ActiveRecord::Migration[6.0]
  def change
    add_column :campaigns, :created_at, :datetime, null: false
    add_column :campaigns, :updated_at, :datetime, null: false
  end
end
