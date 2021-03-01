require "application_system_test_case"

class GroupsTest < ApplicationSystemTestCase
  test "visiting the index" do
    login_as users(:chrystelle)
    visit groups_url

    save_and_open_screenshot
    assert_selector ".twi-container h1", text: "Mes groupes projet"
  end
end
