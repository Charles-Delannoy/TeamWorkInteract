require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "full_name return a capitalized first AND last name if both present, nil otherwise" do
    user = User.new(first_name: 'Roger', last_name: 'waters')
    assert_equal "Roger Waters", user.full_name

    user = User.new(first_name: 'Roger')
    assert_nil user.full_name

    user = User.new(last_name: 'waters')
    assert_nil user.full_name

    user = User.new()
    assert_nil user.full_name

    green_bg('User test')
    green('"full_name return a capitalized first AND last name if both present, nil otherwise')
  end
end
