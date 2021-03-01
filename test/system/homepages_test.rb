require "application_system_test_case"

class HomepagesTest < ApplicationSystemTestCase
  test "visiting the homepage" do
    # Setup => No setup
    # Exercise
    visit root_url
    # Verify
    assert_selector ".home-pic-banner h1", text: "Team Work Interact"
    # save_and_open_screenshot
    # Teardown => No teardown
  end
end
