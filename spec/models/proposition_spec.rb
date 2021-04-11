require 'rails_helper'

RSpec.describe Proposition, type: :model do
  fixtures :questions
  context 'validations' do
    it 'should validate title presence' do
      proposition = build(:proposition_no_title)
      proposition.validate
      expect(proposition.errors.messages[:title]).to include("can't be blank")
    end

    it 'should validate title length' do
      proposition = build(:proposition_short_title)
      proposition.validate
      expect(proposition.errors.messages[:title]).to include("is too short (minimum is 3 characters)")
    end

    it 'should validate value presence' do
      proposition = build(:proposition_no_value)
      proposition.validate
      expect(proposition.errors.messages[:value]).to include("can't be blank")
    end

    it 'should validate only positive value' do
      proposition = build(:proposition_negative_value)
      proposition.validate
      expect(proposition.errors.messages[:value]).to include("must be greater than or equal to 0")
    end

    it 'should validate question existence' do
      proposition = build(:proposition)
      proposition.validate
      expect(proposition.errors.messages[:question]).to include("must exist")
    end

    it 'should persist proposition if validation are ok' do
      n_proposition = Proposition.count
      proposition = build(:proposition)
      proposition.question = questions(:climat)
      proposition.save
      expect(Proposition.count).to eq(n_proposition + 1)
    end
  end
end
