require 'rails_helper'

RSpec.describe Group, type: :model do
  fixtures :users
  context 'validations' do
    it 'should validate the name presence' do
      group = build(:group_no_name)
      group.validate
      expect(group.errors.messages[:name]).to include("can't be blank")
    end

    it 'should validate the name length' do
      group = build(:group_short_name)
      group.validate
      expect(group.errors.messages[:name]).to include("is too short (minimum is 3 characters)")
    end

    it 'should validate the description length' do
      group = build(:group_short_description)
      group.validate
      expect(group.errors.messages[:description]).to include("is too short (minimum is 10 characters)")
    end

    it 'should validate the description presence' do
      group = build(:group_no_description)
      group.validate
      expect(group.errors.messages[:description]).to include("can't be blank")
    end

    it 'should validate the start_date presence' do
      group = build(:group_no_start)
      group.validate
      expect(group.errors.messages[:start_date]).to include("can't be blank")
    end

    it 'should validate the end_date presence' do
      group = build(:group_no_end)
      group.validate
      expect(group.errors.messages[:end_date]).to include("can't be blank")
    end

    it 'should validate that start_date is before end_date' do
      group = build(:group_start_after_end)
      group.validate
      expect(group.errors).to include(:end_date)
      expect(group.errors.messages[:end_date]).to include("must be after starts_at")
    end

    it 'should validate user existence' do
      group = build(:group)
      group.validate
      expect(group.errors).to include(:user)
      expect(group.errors.messages[:user]).to include("must exist")
    end

    it 'should persist a group when validations are fullfilled' do
      n_group = Group.count
      group = build(:group)
      group.user = users(:chrystelle)
      group.save
      expect(Group.count).to eq(n_group + 1)
    end
  end
end
