require 'rails_helper'

RSpec.describe Recommandation, type: :model do
  context 'validation' do
    it 'should validate description length' do
      reco = build(:recommandation_empty)
      reco.validate
      expect(reco.errors.messages).to include(:description)
      expect(reco.valid?).to be false
    end

    it 'should accept correct description' do
      reco = build(:recommandation, axe: build(:axe))
      reco.validate
      expect(reco.valid?).to be true
    end
  end
end
