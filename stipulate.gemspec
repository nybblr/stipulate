# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "stipulate/version"

Gem::Specification.new do |s|
  s.name        = "stipulate"
  s.version     = Stipulate::VERSION
  s.authors     = ["Jonathan Martin"]
  s.email       = ["me@nybblr.com"]
  s.homepage    = "http://nybblr.com"
  s.summary     = %q{Very often "statusesque" string fields are used for maximum flexibility in designing state-sensitive models, such as a "pending" order or an "inactive" user. Homebrew solutions leave the individual statuses undocumented and require string sensitive comparisons. This gem introduces readability and adds some convenient method generation so that code remains readable, but just as flexible as the string field backing it. Be sure to check out www.nybblr.com for other Rails goodies, and if you're looking for more of my gems (when I get around to it!) go to nybblr.com/gems.}
  s.description = %q{Enumeration helper for ActiveRecord string fields}

  s.rubyforge_project = "stipulate"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
