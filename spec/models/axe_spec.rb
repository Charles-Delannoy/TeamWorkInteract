require 'rails_helper'

RSpec.describe Axe, type: :model do
  # setup
  fixtures :users
  context 'validations' do
    it 'should check for title presence' do
      axe = build(:axe_no_title)
      axe.validate
      expect(axe.errors.messages[:title]).to include("can't be blank")
    end

    it 'should check for title length' do
      axe = build(:axe_short_title)
      axe.validate
      expect(axe.errors.messages[:title]).to include("is too short (minimum is 3 characters)")
    end

    it 'should validate title unicity for a user' do
      Axe.create(title: "communication", description: "savoir bien communiquer", user: users(:chrystelle))
      axe = Axe.new(title: "communication", description: "savoir bien communiquer", user: users(:chrystelle))
      axe.validate
      expect(axe.errors.messages[:title]).to include("has already been taken")
    end

    it 'should check for description length' do
      axe = build(:axe_short_description)
      axe.validate
      expect(axe.errors.messages[:description]).to include("is too short (minimum is 10 characters)")
    end

    it 'should check for description presence' do
      axe = build(:axe_no_description)
      axe.validate
      expect(axe.errors.messages[:description]).to include("can't be blank")
    end

    it 'should validate user existence' do
      axe = build(:axe)
      axe.validate
      expect(axe.errors).to include(:user)
      expect(axe.errors.messages[:user]).to include("must exist")
    end

    it 'should persist an axe if validations are ok' do
      count = Axe.all.length
      Axe.create(title: "communication", description: "savoir bien communiquer", user: users(:chrystelle))
      expect(Axe.count).to eq(count + 1)
    end
  end
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
end
