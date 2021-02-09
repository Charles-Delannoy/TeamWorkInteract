class CreateGroupCampaigns < ActiveRecord::Migration[6.0]
  def change
    create_table :group_campaigns do |t|
      t.references :group, null: false, foreign_key: true
      t.references :campaign, null: false, foreign_key: true

      t.timestamps
    end
  end
end
