require 'rails_helper'

RSpec.describe Answer, type: :model do
  fixtures :users
  fixtures :group_campaigns
  fixtures :groups
  fixtures :propositions
  describe 'validation' do
    it 'should validate user existence' do
      answer = Answer.new
      answer.validate
      expect(answer.errors).to include(:user)
      expect(answer.errors.messages[:user]).to include("must exist")
    end

    it 'should validate group_campaign existence' do
      answer = Answer.new
      answer.validate
      expect(answer.errors).to include(:group_campaign)
      expect(answer.errors.messages[:group_campaign]).to include("must exist")
    end

    it 'should validate proposition existence' do
      answer = Answer.new
      answer.validate
      expect(answer.errors).to include(:proposition)
      expect(answer.errors.messages[:proposition]).to include("must exist")
    end

    it 'should persist an answer if validations are ok' do
      n_answers = Answer.count
      answer = Answer.new
      answer.group_campaign = group_campaigns(:group_campaign_current_group)
      answer.user = users(:charles)
      answer.proposition = propositions(:first_proposition)
      answer.save
      expect(Answer.count).to eq(n_answers + 1)
    end
  end

  describe 'associations' do
    let(:answer) { Answer.new(group_campaign: group_campaigns(:group_campaign_current_group),
                              user: users(:chrystelle),
                              proposition: propositions(:first_proposition)) }
    it 'should link the answer to a group' do
      expect(answer.group).to eq(groups(:current_group_with_campaign))
    end
  end
end
