require "application_system_test_case"

class GroupsTest < ApplicationSystemTestCase

  test "visiting the group index" do

    login_as users(:chrystelle)
    visit groups_url

    nb_group = Group.where(user: users(:chrystelle)).length

    green_bg("Visiting the group index")

    assert_selector ".twi-container h1", text: "Mes groupes projet"
    green("Group index title OK")

    assert_selector ".group-card", count: nb_group
    green("Group count OK => Chrystelle has #{nb_group} groups")
    # save_and_open_screenshot
  end


  test "let an admin user to create a new group" do
    login_as users(:chrystelle)
    visit groups_url

    nb_group = Group.where(user: users(:chrystelle)).length

    fill_in "group_name", with: "Le Wagon"
    fill_in "group_description", with: "Changez de vie, apprenez à coder."
    # fill_in "range_start", with: "2021-03-01"
    # fill_in "range_end", with: "2021-05-04"
    click_on 'Créer'

    assert_equal groups_path, page.current_path
    # Test title
    green_bg("Create a group")
    # Part test result
    green("Redirection OK")

    assert_text "Changez de vie, apprenez à coder."
    # Part test result
    green("New group is displayed")
    assert_equal nb_group + 1, Group.where(user: users(:chrystelle)).length
    # Part test result
    green("New group is created and linked to the user")
  end
end
