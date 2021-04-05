class GroupCampaign < ApplicationRecord
  belongs_to :group
  belongs_to :campaign
  has_one :survey, through: :campaign
  has_many :axes, through: :survey
  has_many :answers
  validate :unfinished_group, if: :group
  validate :campaign_within_group_dates, if: :group && :campaign
  validate :no_other_campaign_ongoing, if: :group

  def score_calculation
    scores = {}
    n_answers = {}
    axes.each { |axe| scores[axe.id] = 0 && n_answers[axe.id] = 0 }
    answers.each do |answer|
      scores[answer.axe.id] += answer.proposition.value
      n_answers[answer.axe.id] += 1
    end
    scores.each { |axe_id, score| scores[axe_id] = score / n_answers[axe_id] }
    scores
  end

  private

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
