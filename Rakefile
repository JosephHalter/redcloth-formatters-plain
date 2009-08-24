# load rspec as GEM or plugin
rspec_gem_dir = nil
Dir["#{File.dirname(__FILE__)}/../../gems/*"].each do |subdir|
  rspec_gem_dir = subdir if subdir.gsub("#{File.dirname(__FILE__)}/../../gems/","") =~ /^(\w+-)?rspec-(\d+)/ && File.exist?("#{subdir}/lib/spec/rake/spectask.rb")
end
rspec_plugin_dir = File.expand_path(File.dirname(__FILE__) + '/../rspec')
if rspec_gem_dir && (test ?d, rspec_plugin_dir)
  raise "\n#{'*'*50}\nYou have rspec installed in both vendor/gems and vendor/plugins\nPlease pick one and dispose of the other.\n#{'*'*50}\n\n"
end
if rspec_gem_dir
  $:.unshift("#{rspec_gem_dir}/lib") 
elsif File.exist?(rspec_plugin_dir)
  $:.unshift("#{rspec_plugin_dir}/lib")
end

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
