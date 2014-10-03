begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'
require 'rspec/core/rake_task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'HandRecordUtility'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
#  t.pattern = 'test/**/*_test.rb'
  t.pattern = 'test/*_test.rb'
  t.verbose = false
end

RSpec::Core::RakeTask.new(:spec) do |config|
  # Need to fix. Get errors about pattern.
  config.pattern = "spec/*_spec.rb"
end

#task default: :test
task :default => :spec
