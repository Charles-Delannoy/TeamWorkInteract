require 'rails_helper'

RSpec.describe Axe, type: :model do
  # setup
  fixtures :users
  context 'recommandation association' do
    it 'should increment recommandations_count' do
      # Exercise
      axe = build(:axe)
      axe.user = users(:chrystelle)
      axe.recommandations << build(:recommandation)
      axe.save
      # Verify
      expect(Recommandation.count).to eq(1)
      expect(axe.recommandations.count).to eq(1)
    end
  end

  it 'should persist an axe' do
    # Exercise
    count = Axe.all.length
    Axe.create(title: "communication", description: "savoir bien communiquer", user: users(:chrystelle))
    # Verify
    expect(Axe.count).to eq(count + 1)
  end
end
