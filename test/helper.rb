require 'bundler/setup'

if ENV['CODECLIMATE_REPO_TOKEN']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require 'minitest/autorun'
require 'testem'

require 'simple_assertions'

class Spec < Testem
end
