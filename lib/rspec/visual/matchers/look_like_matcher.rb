require 'rspec'
require 'rspec/expectations'
require 'fileutils'

RSpec::Matchers.define :look_like do |expected|
  expected_image_file_path = File.join(Rspec::Visual::Configuration.stable_screenshot_folder, "#{expected}.png")
  actual_image_file_path = File.join(Rspec::Visual::Configuration.screenshot_folder, "#{expected}.png")

  match do |actual|
    unless File.exists?(expected_image_file_path)
      FileUtils.cp(actual_image_file_path, expected_image_file_path) and return true
    end

    diff_file_path = File.join(Rspec::Visual::Configuration.screenshot_folder, "#{expected}_diff.png")
    system "compare -metric PAE -subimage-search -dissimilarity-threshold 1 \
          #{expected_image_file_path} #{actual_image_file_path} #{diff_file_path}"
  end

  failure_message do |actual|
    "expected #{actual_image_file_path} to look like #{expected_image_file_path}\n"\
    "If you intended #{expected} to look diffrently, please copy over "\
    "#{actual_image_file_path} into #{Rspec::Visual::Configuration.stable_screenshot_folder}"
  end
end
