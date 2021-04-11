require 'rails_helper'

RSpec.describe Survey, type: :model do
  fixtures :users
  context 'validation' do
    it 'should validate title presence' do
      survey = build(:survey_no_title)
      survey.validate
      expect(survey.errors.messages[:title]).to include("can't be blank")
    end

    it 'should validate title length' do
      survey = build(:survey_no_title)
      survey.validate
      expect(survey.errors.messages[:title]).to include("is too short (minimum is 3 characters)")
    end

    it 'should validate description presence' do
      survey = build(:survey_no_description)
      survey.validate
      expect(survey.errors.messages[:description]).to include("can't be blank")
    end

    it 'should validate description length' do
      survey = build(:survey_no_description)
      survey.validate
      expect(survey.errors.messages[:description]).to include("is too short (minimum is 10 characters)")
    end

    it 'should validate user existence' do
      survey = build(:survey)
      survey.validate
      expect(survey.errors.messages[:user]).to include("must exist")
    end

    it 'should persist survet if validations are ok' do
      n_survey = Survey.count
      survey = build(:survey)
      survey.user = users(:chrystelle)
      survey.save
      expect(Survey.count).to eq(n_survey + 1)
    end
  end
end
