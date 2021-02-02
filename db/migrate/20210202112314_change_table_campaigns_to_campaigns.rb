class ChangeTableCampaignsToCampaigns < ActiveRecord::Migration[6.0]
  def change
    rename_table :table_campaigns, :campaigns
  end
end
