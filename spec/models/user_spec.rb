require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users
  describe "#full_name" do
    it 'return a string' do
      expect(users(:chrystelle).full_name).to be_a(String)
    end

    it 'return nil if there is no first_name' do
      user = create(:user_no_first_name)
      expect(user.full_name).to eq(nil)
    end

    it 'return nil if there is no last_name' do
      user = create(:user_no_last_name)
      expect(user.full_name).to eq(nil)
    end


    it 'return the full_name if first & last name provided' do
      expect(users(:chrystelle).full_name).to eq("Chrystelle Gaujard")
    end
  end

  describe "#completion_rate" do
    before(:each) do
      # Groupe de test
      group = build(:group)
      group.user = users(:chrystelle)
      group.save

      # Group Users de test
      user_group1 = build(:user_group)
      user_group1.user = users(:georges)
      user_group2 = build(:user_group)
      user_group2.user = users(:charles)
      user_group3 = build(:user_group)
      user_group3.user = users(:thibaud)
      user_group1.group = user_group2.group = user_group3.group = group
      user_group1.save
      user_group2.save
      user_group3.save

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
      (1..4).each do |j|
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
        answer1.group_campaign = @group_campaign
        answer1.user = users(:georges)
        answer1.proposition = propositions[2]
        answer1.save
        if j%2 == 0
          answer2 = Answer.new
          answer2.group_campaign = @group_campaign
          answer2.user = users(:thibaud)
          answer2.proposition = propositions[2]
          answer2.save
        end
      end
    end

    it 'return an integer' do
      expect(users(:georges).completion_rate(@group_campaign)).to be_a(Integer)
    end

    it 'return 100 if all questions has been answered' do
      expect(users(:georges).completion_rate(@group_campaign)).to eq(100)
    end

    it 'return 0 if no questions has been answered' do
      expect(users(:charles).completion_rate(@group_campaign)).to eq(0)
    end

    it 'return 50 if half questions has been answered' do
      expect(users(:thibaud).completion_rate(@group_campaign)).to eq(50)
    end
  end
end
