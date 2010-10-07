# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/red_cloth_formatters_plain')
$:.unshift lib unless $:.include?(lib)
 
require 'lib/red_cloth_formatters_plain'
 
Gem::Specification.new do |s|
  s.name        = "red_cloth_formatters_plain"
  s.version     = RedCloth::Formatters::Plain::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Joseph Halter", "Jeff Zellman"]
  s.email       = ["jzellman@gmail.com"]
#  s.homepage    = "http://github.com/jzellman/redcloth-formatters-plain"
#  s.homepage    = "http://github.com/JosephHalter/redcloth-formatters-plain"
 
  s.summary     = "Redcloth Plain Text Formatter"
  s.description = "Allows Redcloth to output plain text"
  s.required_rubygems_version = ">= 1.3.6"
#  s.rubyforge_project         = ""
 
  s.add_development_dependency "rspec"
  s.add_dependency "RedCloth" 
  s.files        = Dir.glob("{lib}/**/*") + %w(MIT-LICENSE README.textile Rakefile init.rb)
  s.require_path = 'lib'
end