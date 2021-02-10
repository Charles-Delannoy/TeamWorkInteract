class AddGroupAndCampaignToGroupCampaign < ActiveRecord::Migration[6.0]
  def change
    add_reference :group_campaigns, :group, null: false, foreign_key: true
    add_reference :group_campaigns, :campaign, null: false, foreign_key: true
  end
end
