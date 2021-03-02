require 'rails_helper'

RSpec.describe Axe, type: :model do
  it 'should persist an axe' do
    user = User.create!(first_name: "chrystelle", last_name: "Gaujard", email: "cg@twi.fr", password: '123456', admin: 'Y')
    Axe.create(title: "communication", description: "savoir bien communiquer", user: user)
    expect(Axe.count).to eq(1)
  end
end
