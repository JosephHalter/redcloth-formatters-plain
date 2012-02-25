require "bundler/gem_tasks"
require "rspec/core/rake_task"
RSpec::Core::RakeTask.new("spec").tap do |config|
  config.rspec_opts = "--color"
end
task :default => :spec
