require 'rails_helper'

RSpec.describe Axe, type: :model do
  # Teardown
  User.destroy_all
  # Setup
  user = User.create!(first_name: "chrystelle", last_name: "Gaujard", email: "cg@twi.fr", password: '123456', admin: 'Y')

  context 'recommandation association' do
    it 'should increment recommandations_count' do
      # Exercise
      axe = Axe.new(title: "communication", description: "savoir bien communiquer", user: user)
      axe.recommandations << Recommandation.new(title: 'Reunions hebdo', description: 'Prévoir des rencontres régulières')
      axe.save
      # Verify
      expect(Recommandation.count).to eq(1)
      expect(axe.recommandations.count).to eq(1)
    end
  end

  it 'should persist an axe' do
    # Exercise
    Axe.create(title: "communication", description: "savoir bien communiquer", user: user)
    # Verify
    expect(Axe.count).to eq(1)
  end
end
