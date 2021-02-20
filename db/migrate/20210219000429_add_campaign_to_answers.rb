class AddCampaignToAnswers < ActiveRecord::Migration[6.0]
  def change
    add_reference :answers, :campaign, null: false, foreign_key: true
  end
end
