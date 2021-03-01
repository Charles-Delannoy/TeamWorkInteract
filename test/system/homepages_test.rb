require "application_system_test_case"

class HomepagesTest < ApplicationSystemTestCase
  test "visiting the homepage" do
    # Setup => No setup
    # Exercise
    visit root_url
    # Verify
    # save_and_open_screenshot
    green_bg("Visiting the homepage")

    assert_selector ".home-pic-banner h1", text: "Team Work Interact"
    green("Homepage title OK")
    # Teardown => No teardown
  end
end
