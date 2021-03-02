require 'rails_helper'

RSpec.describe Recommandation, type: :model do
  context 'validation' do
    it 'should validate description length' do
      reco = Recommandation.new(description: 'bla')
      reco.validate
      expect(reco.errors.messages).to include(:description)
      expect(reco.valid?).to be false
    end
  end
end
