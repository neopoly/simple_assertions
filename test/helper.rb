require 'bundler/setup'

require 'minitest/spec'
require 'minitest/autorun'

require 'simple_assertions'

class Spec < MiniTest::Spec
  class << self
    alias :context :describe
    alias :test :it
  end
end
