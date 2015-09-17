require 'singleton'

module Rspec
  module Visual
    class Configuration
      include Singleton

      class << self
        attr_accessor :screenshot_folder

        def configure
          yield self
        end

        def latest_commit_hash
          @latest_commit_hash ||= `git rev-parse HEAD`.strip
        end

        def latest_master_commit_hash
          @latest_master_commit_hash ||=`git rev-parse master`.strip
        end
      end
    end
  end
end
