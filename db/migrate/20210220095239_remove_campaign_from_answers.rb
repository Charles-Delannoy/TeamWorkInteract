class RemoveCampaignFromAnswers < ActiveRecord::Migration[6.0]
  def change
    remove_reference :answers, :campaign, null: false, foreign_key: true
  end
end
