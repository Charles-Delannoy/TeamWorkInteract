require 'rails_helper'

RSpec.describe GroupCampaign, type: :model do
  fixtures :users
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
    context '5 based questions' do
      before(:each) do
        # Groupe de test
        group = build(:group)
        group.user = users(:chrystelle)
        group.save

        # Group Users de test
        user_group1 = build(:user_group)
        user_group1.user = users(:georges)
        user_group2 = build(:user_group_referent)
        user_group2.user = users(:charles)
        user_group1.group = user_group2.group = group
        user_group1.save
        user_group2.save

        # survey
        @survey = build(:survey)
        @survey.user = users(:chrystelle)
        @survey.save

        # campagne
        campaign = build(:campaign)
        campaign.survey = @survey
        campaign.save

        # group_campaign
        @group_campaign = GroupCampaign.new
        @group_campaign.group = group
        @group_campaign.campaign = campaign
        @group_campaign.save

        # axes & questions
        @axes = []
        4.times do
          axe = build(:axe)
          axe.user = users(:chrystelle)
          axe.save
          @axes << axe

          question = build(:question)
          question.survey = @survey
          question.axe = axe
          question.save

          propositions = []
          (0..5).each do |i|
            proposition = build(:proposition)
            proposition.value = i
            proposition.question = question
            proposition.save
            propositions << proposition
          end

          # Answers
          answer1 = Answer.new
          answer2 = Answer.new
          answer1.group_campaign = answer2.group_campaign = @group_campaign
          answer1.user = users(:georges)
          answer2.user = users(:charles)
          answer1.proposition = answer2.proposition = propositions[2]
          answer1.save
          answer2.save
        end

        @score_hash = @group_campaign.score_calculation
      end

      it 'should return a hash' do
        expect(@score_hash).to be_a(Hash)
      end

      it 'has an axe as a key' do
        expect(@score_hash.keys.first).to be_a(Axe)
      end

      it 'has a float as a value' do
        first_key = @score_hash.keys.first
        expect(@score_hash[first_key]).to be_a(Float)
      end

      it 'create a key for each axe included in the survey' do
        expect(@score_hash.keys.length).to eq(4)
      end

      context 'Same Coef for all questions' do
        it 'calculate the score for the first axe' do
          first_key = @score_hash.keys.first
          expect(@score_hash[first_key]).to eq(2.0)
        end

        it 'calculate the score for all axes' do
          axes_ids = @score_hash.keys
          expect(axes_ids.empty?).to be(false)
          axes_ids.each { |key| expect(@score_hash[key]).to eq(2.0) }
        end
      end

      context 'Different coefs for questions' do
        before(:each) do
          question = build(:question_coef2)
          question.survey = @survey
          question.axe = @axes.first
          question.save

          proposition = build(:proposition)
          proposition.value = 5
          proposition.question = question
          proposition.save

          answer1 = Answer.new
          answer2 = Answer.new
          @group_campaign.answers << answer1
          @group_campaign.answers << answer2
          answer1.user = users(:georges)
          answer2.user = users(:charles)
          answer1.proposition = answer2.proposition = proposition
          answer1.save
          answer2.save

          @score_hash = @group_campaign.score_calculation
        end
        it 'calculate the score for the first axe' do
          first_key = @axes.first
          expect(@score_hash[first_key]).to eq(2.33)
        end

        it 'still calculate the other scores too' do
          axes_ids = @score_hash.keys
          expect(axes_ids.empty?).to be(false)
          axes_ids.each { |key| expect(@score_hash[key]).to eq(2) unless key == @axes.first }
        end
      end
    end

    context '10 bases questions' do
      before(:each) do
        # Groupe de test
        group = build(:group)
        group.user = users(:chrystelle)
        group.save

        # Group Users de test
        user_group1 = build(:user_group)
        user_group1.user = users(:georges)
        user_group2 = build(:user_group_referent)
        user_group2.user = users(:charles)
        user_group1.group = user_group2.group = group
        user_group1.save
        user_group2.save

        # survey
        @survey = build(:survey)
        @survey.user = users(:chrystelle)
        @survey.save

        # campagne
        campaign = build(:campaign)
        campaign.survey = @survey
        campaign.save

        # group_campaign
        @group_campaign = GroupCampaign.new
        @group_campaign.group = group
        @group_campaign.campaign = campaign
        @group_campaign.save

        # axes & questions
        @axes = []
        4.times do
          axe = build(:axe)
          axe.user = users(:chrystelle)
          axe.save
          @axes << axe

          question = build(:question)
          question.survey = @survey
          question.axe = axe
          question.save

          propositions = []
          (0..10).each do |i|
            proposition = build(:proposition)
            proposition.value = i
            proposition.question = question
            proposition.save
            propositions << proposition
          end

          # Answers
          answer1 = Answer.new
          answer2 = Answer.new
          answer1.group_campaign = answer2.group_campaign = @group_campaign
          answer1.user = users(:georges)
          answer2.user = users(:charles)
          answer1.proposition = answer2.proposition = propositions[4]
          answer1.save
          answer2.save
        end

        @score_hash = @group_campaign.score_calculation
      end

      it 'calculate the score for the first axe in base 5' do
          first_key = @score_hash.keys.first
          expect(@score_hash[first_key]).to eq(2.0)
        end

        it 'calculate the score for all axes in base 5' do
          axes_ids = @score_hash.keys
          expect(axes_ids.empty?).to be(false)
          axes_ids.each { |key| expect(@score_hash[key]).to eq(2.0) }
        end
    end
  end
end
