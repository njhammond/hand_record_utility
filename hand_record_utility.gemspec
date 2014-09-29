$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hand_record_utility/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hand_record_utility"
  s.version     = HandRecordUtility::VERSION
  s.authors     = ["Nicolas Hammond"]
  s.email       = ["gemwriter@hammondsoftware.com"]
  s.homepage    = "TODO: A Home page. There is no home page for this project"
  s.summary     = "Converts a hand record to a unique number."
  s.description = "Takes a hand record (4 hands of 13 cards) and converts to a unique number using Richard Pavlicek's algorithm. The reverse also applies. The number will be in the range of [1..53644737765488792839237440000].

See Richard Pavlicek's web site at http://rpbridge.net/7z68.htm.

See Thomas Andrews' web site at http://bridge.thomasoandrews.com/impossible/bin/impossible.cgi.
"  
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # For testing
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
