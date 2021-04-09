require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users
  describe "#full_name" do
    it 'return a string' do
      expect(users(:chrystelle).full_name).to be_a(String)
    end

    it 'return nil if there is no first_name' do
      user = create(:user_no_first_name)
      expect(user.full_name).to eq(nil)
    end

    it 'return nil if there is no last_name' do
      user = create(:user_no_last_name)
      expect(user.full_name).to eq(nil)
    end


    it 'return the full_name if first & last name provided' do
      expect(users(:chrystelle).full_name).to eq("Chrystelle Gaujard")
    end
  end
end
