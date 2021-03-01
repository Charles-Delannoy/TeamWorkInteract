require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  driven_by :headless_chrome

  def green(text)
    puts "\e[32m#{text}\e[0m"
  end

  def green_bg(text)
    puts "\e[42m#{text}\e[0m"
  end
end
