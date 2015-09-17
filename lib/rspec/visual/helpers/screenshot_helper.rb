require 'rspec/visual/configuration'
module ScreenshotHelper
  def take_screenshot(page, example)
    latest_commit = Rspec::Rotten::Configuration.latest_commit_hash
    file_path = File.join(Rspec::Rotten::Configuration.screenshot_folder,
                          "#{latest_commit}/#{example.description}.png"
    page.save_screenshot(Rails.root.join(file_path), full: true)
  end
end
