# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "red_cloth_formatters_plain"
  s.version     = "0.3.0"
  s.authors     = ["Joseph Halter", "Jeff Zellman"]
  s.email       = ["joseph@openhood.com", "jzellman@gmail.com"]
  s.homepage    = "https://github.com/JosephHalter/redcloth-formatters-plain"
  s.summary     = "Redcloth Plain Text Formatter"
  s.description = "Allows Redcloth to output plain text"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_dependency "RedCloth", ">= 4.2.3"
end
