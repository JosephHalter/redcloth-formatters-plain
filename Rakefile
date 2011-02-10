require "rubygems"
require "bundler/setup"
Bundler.require

# load rspec tasks
require "rake"
require "spec/rake/spectask"

desc "Default: run specs."
task :default => :spec

desc "Run the specs"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ["--colour --format progress --loadby mtime --reverse"]
  t.spec_files = FileList["spec/**/*_spec.rb"]
end

$LOAD_PATH.unshift File.expand_path("../lib/", __FILE__)
require "red_cloth_formatters_plain"
 
task :build do
  system "gem build redcloth-formatters-plain.gemspec"
end
 
task :release => :build do
  system "gem push red_cloth_formatters_plain-#{RedCloth::Formatters::Plain::VERSION}.gem"
end
