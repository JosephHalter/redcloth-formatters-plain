# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", 'red_cloth_formatters_plain') 
require 'red_cloth_formatters_plain/version'
 
Gem::Specification.new do |s|
  s.name        = "red_cloth_formatters_plain"
  s.version     = RedCloth::Formatters::Plain::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Joseph Halter", "Jeff Zellman"]
  s.email       = ["jzellman@gmail.com"]
 
  s.summary     = "Redcloth Plain Text Formatter"
  s.description = "Allows Redcloth to output plain text"
  
  s.required_rubygems_version = ">= 1.3.6"
 
  s.add_development_dependency "rspec", "~> 1"
  s.add_dependency "RedCloth", "4.2.5"

  s.files        = Dir.glob("{lib}/**/*") + %w(MIT-LICENSE README.textile Rakefile init.rb)
  s.require_paths = ['lib']
end
