require 'rails_helper'

RSpec.describe GroupCampaign, type: :model do
  fixtures :groups
  fixtures :campaigns
  fixtures :group_campaigns
  fixtures :questions
  fixtures :propositions
  fixtures :answers

  context 'validation' do
    it 'should validate group existence' do
      group_campaign = GroupCampaign.new
      group_campaign.validate
      expect(group_campaign.errors).to include(:group)
      expect(group_campaign.errors.messages[:group]).to include("must exist")
    end

    it 'should validate campaign existence' do
      group_campaign = GroupCampaign.new
      group_campaign.validate
      expect(group_campaign.errors).to include(:campaign)
      expect(group_campaign.errors.messages[:campaign]).to include("must exist")
    end

    it 'should check if the associated group has not ended yet' do
      group_campaign = GroupCampaign.new
      group_campaign.group = groups(:past_group)
      group_campaign.validate
      expect(group_campaign.errors).to include(:group)
      expect(group_campaign.errors.messages[:group]).to include("must not be finished")
    end

    it 'should check if the campaign is within the group dates' do
      group_campaign = GroupCampaign.new
      group_campaign.campaign = campaigns(:late_finish_campaign)
      group_campaign.group = groups(:current_group)
      group_campaign.validate
      expect(group_campaign.errors).to include(:campaign)
      expect(group_campaign.errors.messages[:campaign]).to include("must be within the group dates")
    end

    it 'should check if the group has no other campaigns at the same time' do
      group_campaign = GroupCampaign.new
      group_campaign.campaign = campaigns(:campaign_s1)
      group_campaign.group = groups(:current_group_with_campaign)
      group_campaign.validate
      expect(group_campaign.errors).to include(:campaign)
      expect(group_campaign.errors.messages[:campaign]).to include("already a campaign on same dates")
    end

    it 'should persist a group_campaign if validations are ok' do
      n_group_campaign = GroupCampaign.count
      group_campaign = GroupCampaign.new
      group_campaign.campaign = campaigns(:campaign_s1)
      group_campaign.group = groups(:current_group)
      group_campaign.save
      expect(GroupCampaign.count).to eq(n_group_campaign + 1)
    end
  end

  context '#score_calculation' do
    let(:score_hash) { group_campaigns(:group_campaign_current_group).score_calculation }

    it 'should return a hash' do
      expect(score_hash).to be_a(Hash)
    end

    it 'has an axe id as a key' do
      axe = Axe.find(score_hash.keys.first)
      expect(axe).to be_a(Axe)
    end

    it 'has an integer as value' do
      first_key = score_hash.keys.first
      expect(score_hash[first_key]).to be_a(Integer)
    end

    it 'create a key for each axe included in the survey' do
      expect(score_hash.keys.length).to eq(7)
    end

    it 'calculate the score for the first axe' do
      expect(score_hash[first_key]).to eq(2)
    end

    it 'calculate the score for all axes' do
      expect(score_hash.keys.empty?).to be(false)
      score_hash.keys.each { |key| expect(score_hash[key]).to eq(2) }
    end
  end
end
