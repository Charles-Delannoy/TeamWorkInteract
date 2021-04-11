require 'rails_helper'

RSpec.describe Recommandation, type: :model do
  context 'validation' do
    it 'should validate title presence' do
      reco = build(:recommandation_no_title)
      reco.validate
      expect(reco.errors.messages).to include(:title)
      expect(reco.errors.messages[:title]).to include("can't be blank")
      expect(reco.valid?).to be false
    end

    it 'should validate title length' do
      reco = build(:recommandation_no_title)
      reco.validate
      expect(reco.errors.messages).to include(:title)
      expect(reco.errors.messages[:title]).to include("is too short (minimum is 3 characters)")
      expect(reco.valid?).to be false
    end

    it 'should validate description presence' do
      reco = build(:recommandation_no_description)
      reco.validate
      expect(reco.errors.messages).to include(:description)
      expect(reco.errors.messages[:description]).to include("can't be blank")
      expect(reco.valid?).to be false
    end

    it 'should validate description length' do
      reco = build(:recommandation_no_description)
      reco.validate
      expect(reco.errors.messages).to include(:description)
      expect(reco.errors.messages[:description]).to include("is too short (minimum is 10 characters)")
      expect(reco.valid?).to be false
    end

    it 'should accept correct description' do
      reco = build(:recommandation, axe: build(:axe))
      reco.validate
      expect(reco.valid?).to be true
    end
  end
end
