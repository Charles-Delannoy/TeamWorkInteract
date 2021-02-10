class CreateGroupCampaigns < ActiveRecord::Migration[6.0]
  def change
    create_table :group_campaigns do |t|

      t.timestamps
    end
  end
end
