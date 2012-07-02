require 'helper'

class SimpleAssertionsAssertRaisesTest < Spec
  class MyError < StandardError
    attr_reader :param

    def initialize(param)
      super "Param: #{param}"
      @param = param
    end

    def paula
      :sir
    end
    private :paula

    def enemy
      :war
    end
    protected :enemy
  end

  def my_error!(param=nil)
    raise MyError, param
  end

  include SimpleAssertions::AssertRaises

  context :assert_raises do
    test "exact param match" do
      assert_raises MyError, :param => "string" do
        my_error! "string"
      end
    end

    test "regexp param match" do
      assert_raises MyError, :param => /string/i do
        my_error! "my STRING rocks"
      end
    end

    test "param does not match on === operator" do
      assert_raises MiniTest::Assertion, :message => /"foo".*=== "bar"/ do
        assert_raises MyError, :param => "foo" do
          my_error! "bar"
        end
      end
    end

    test "exception does not respond to invalid param" do
      assert_raises MiniTest::Assertion, :message => /to respond to #invalid/ do
        assert_raises MyError, :invalid => "foo" do
          my_error!
        end
      end
    end

    test "access to private exception param" do
      assert_raises MiniTest::Assertion, :message => /to respond to #paula/ do
        assert_raises MyError, :paula => :sir do
          my_error!
        end
      end
    end

    test "access to protected exception param" do
      assert_raises NoMethodError do
        assert_raises MyError, :enemy => :war do
          my_error!
        end
      end
    end
  end
end