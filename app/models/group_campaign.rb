class GroupCampaign < ApplicationRecord
  belongs_to :group
  belongs_to :campaign
  validate :unfinished_group, if: :group
  validate :campaign_within_group_dates, if: :group && :campaign
  validate :no_other_campaign_ongoing, if: :group

  def unfinished_group
    errors.add :group, "must not be finished" if Date.today > group.end_date
  end

  def campaign_within_group_dates
    errors.add :campaign, "must be within the group dates" if campaign.end_date > group.end_date ||
                                                              campaign.start_date < group.start_date
  end

  def no_other_campaign_ongoing
    group.campaigns.each do |alt_campaign|
      errors.add :campaign, "already a campaign on same dates" if (alt_campaign.start_date > campaign.start_date &&
                                                                   alt_campaign.start_date < campaign.end_date) ||
                                                                  (alt_campaign.end_date > campaign.end_date &&
                                                                   alt_campaign.start_date > campaign.start_date) ||
                                                                  (alt_campaign.start_date > campaign.start_date &&
                                                                   alt_campaign.end_date > campaign.end_date)
    end
  end
end
