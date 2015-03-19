require "bundler/setup"
require "bundler/gem_tasks"

# Test
require "rake/testtask"
desc "Default: run unit tests."
task default: :spec

Rake::TestTask.new(:spec) do |test|
  test.test_files = FileList.new("spec/**/*_spec.rb")
  test.libs << "spec"
  test.verbose = true
  test.warning = true
end

# RDoc
require "rdoc/task"
RDoc::Task.new do |rdoc|
  rdoc.title    = "Simple assertions"
  rdoc.rdoc_dir = "rdoc"
  rdoc.main     = "README.rdoc"
  rdoc.rdoc_files.include("README.rdoc", "lib/**/*.rb")
end
