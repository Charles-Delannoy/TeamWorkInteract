require 'rails_helper'

RSpec.describe Question, type: :model do
  fixtures :surveys
  fixtures :axes
  context 'validation' do
    it 'should validate title presence' do
      question = build(:question_no_title)
      question.validate
      expect(question.errors.messages[:title]).to include("can't be blank")
    end

    it 'should validate title length' do
      question = build(:question_short_title)
      question.validate
      expect(question.errors.messages[:title]).to include("is too short (minimum is 3 characters)")
    end

    it 'should validate coef presence' do
      question = build(:question_no_coef)
      question.validate
      expect(question.errors.messages[:coef]).to include("can't be blank")
    end

    it 'should validate positive coef' do
      question = build(:question_negative_coef)
      question.validate
      expect(question.errors.messages[:coef]).to include("must be greater than or equal to 0")
    end

    it 'should validate survey existence' do
      question = build(:question)
      question.validate
      expect(question.errors.messages[:survey]).to include("must exist")
    end

    it 'should validate axe existence' do
      question = build(:question)
      question.validate
      expect(question.errors.messages[:axe]).to include("must exist")
    end

    it 'should persist question if validation are ok' do
      n_question = Question.count
      question = build(:question)
      question.survey = surveys(:survey_s1)
      question.axe = axes(:climat)
      question.save
      expect(Question.count).to eq(n_question + 1)
    end
  end
end
