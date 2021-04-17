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
    axes.each { |axe| scores[axe] = n_answers[axe] = 0 }
    answers.each do |answer|
      five_factorizer = max_proposition_value(answer) / 5
      scores[answer.axe] += answer.proposition.value / five_factorizer
      n_answers[answer.axe] += answer.question.coef
    end
    scores.each { |axe_id, score| scores[axe_id] = (score.to_f / n_answers[axe_id]).round(2) }
    scores
  end

  def answered?
    group.members.each do |member|
      return false if member.completion_rate(self) < 100
    end
    true
  end

  private

  def max_proposition_value(answer)
    max = 0
    answer.question.propositions.each do |proposition|
      max = proposition.value > max ? proposition.value : max
    end
    max
  end

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
