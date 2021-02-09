class RemoveGroupFromCampaign < ActiveRecord::Migration[6.0]
  def change
    remove_reference :campaigns, :group, null: false, foreign_key: true
  end
end
