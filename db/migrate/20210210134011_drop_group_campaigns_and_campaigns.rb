class DropGroupCampaignsAndCampaigns < ActiveRecord::Migration[6.0]
  def change
    drop_table :group_campaigns
    drop_table :campaigns
  end
end
