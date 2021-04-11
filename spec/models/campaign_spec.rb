require 'rails_helper'

RSpec.describe Campaign, type: :model do
  fixtures :surveys

  context 'validation' do
    it 'should validate title presence' do
      campaign = build(:campaign_no_title)
      campaign.validate
      expect(campaign.errors).to include(:title)
      expect(campaign.errors.messages[:title]).to include("can't be blank")
    end

    it 'should validate title length: min 4' do
      campaign = build(:campaign_short_title)
      campaign.validate
      expect(campaign.errors).to include(:title)
      expect(campaign.errors.messages[:title]).to include("is too short (minimum is 4 characters)")
    end

    it 'should validate start_date presence' do
      campaign = build(:campaign_no_start)
      campaign.validate
      expect(campaign.errors).to include(:start_date)
      expect(campaign.errors.messages[:start_date]).to include("can't be blank")
    end

    it 'should validate end_date presence' do
      campaign = build(:campaign_no_end)
      campaign.validate
      expect(campaign.errors).to include(:end_date)
      expect(campaign.errors.messages[:end_date]).to include("can't be blank")
    end

    it 'should validate that start_date is before end_date' do
      campaign = build(:campaign_start_after_end)
      campaign.validate
      expect(campaign.errors).to include(:end_date)
      expect(campaign.errors.messages[:end_date]).to include("must be after starts_at")
    end

    it 'should validate survey existence' do
      campaign = build(:campaign)
      campaign.validate
      expect(campaign.errors).to include(:survey)
      expect(campaign.errors.messages[:survey]).to include("must exist")
    end

    it 'should persist a campaign if validations are ok' do
      n_campaign = Campaign.count
      campaign = build(:campaign)
      campaign.survey = surveys(:survey_s1)
      campaign.save
      expect(Campaign.count).to eq(n_campaign + 1)
    end
  end
end
