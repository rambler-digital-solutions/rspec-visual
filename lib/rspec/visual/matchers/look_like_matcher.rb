require 'rspec'
require 'rspec/expectations'

RSpec::Matchers.define :look_like do |expected|
  match do |actual|
    expected_commit_hash = Rspec::Rotten::Configuration.latest_master_commit_hash
    actual_commit_hash = Rspec::Rotten::Configuration.latest_commit_hash
    expected_image_file_path = File.join(Rspec::Rotten::Configuration.screenshot_folder,
                                        "#{expected_commit_hash}/#{expected}.png")
    actual_image_file_path = File.join(Rspec::Rotten::Configuration.screenshot_folder,
                                        "#{actual_commit_hash}/#{expected}.png")

    return true unless File.exists?(expected_image_file_path)

    diff_file_path = File.join(Rspec::Rotten::Configuration.screenshot_folder,
                                "#{actual_commit_hash}/diff.png")
    system "compare -metric PAE -subimage-search -dissimilarity-threshold 1 \
          #{expected_image_file_path} #{actual_image_file_path} #{diff_file_path}"
  end
end
